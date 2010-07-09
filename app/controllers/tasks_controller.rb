class TasksController < ApplicationController
  before_filter :login_required, :only => [:new, :vote_up, :vote_down, :create, :edit, :destroy, :create]

  def participate
    task = Task.find(params[:id])
    task.participants << current_user if task
    redirect_to url_for([task.project, task])
  end
  
  # GET /tasks
  # GET /tasks.xml
  def index
    render :text => '' and return ## TODO
    @tasks = Task.find(:all, :order => 'created_at DESC', :include => :participants)
  end

  # GET /tasks/1
  def show
    @task = Task.find(params[:id], :include => :participants)
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

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
    @task = Task.new(params[:task].merge(:creator => current_user))
    @task.project = Project.find(params[:project_id])
    @task.save
    if @task.errors.empty?
      redirect_to [@task.project, @task]
    else
      render :update do |page|
        page << "handle_form_errors('idea',['title','body'],#{@task.errors.to_hash.to_json})"
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    check_authorization @task
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to [@task.project, @task] }
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
      format.html { redirect_to @task.project }
      format.xml  { head :ok }
    end
  end
end
