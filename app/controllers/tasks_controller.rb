class TasksController < ApplicationController
  before_filter :login_required, :only => [:new, :vote_up, :vote_down, :create, :edit, :destroy, :create]

  def contribute
  end
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.find(:all, :order => 'created_at DESC')
  end

  # GET /tasks/1
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.xml
  def create
    # TODO: sanitize params (safe attr)
    @task = Task.new(params[:task].merge(:author => current_user))
    @task.save
    render :update do |page|
      if @task.errors.empty?
        page.redirect_to tasks_path
      else
        page << "handle_form_errors('idea',['title','body'],#{@task.errors.to_hash.to_json})"
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @idea = Task.find(params[:id])
    # check authorization
    respond_to do |format|
      if @task.update_attributes(params[:idea])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    check_authorization @task
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
