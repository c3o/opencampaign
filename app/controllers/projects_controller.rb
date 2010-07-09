class ProjectsController < ApplicationController
  before_filter :login_required, :only => [:new, :vote_up, :vote_down, :create, :edit, :destroy, :create]
  
  # GET /tasks
  # GET /tasks.xml
  def index
    is_active = (params[:is_active] == false) ? false : true
    @projects = Project.find(:all, :order => 'created_at ASC', :conditions => ['is_active = ?', is_active], :include => :tasks)
    render :template => "projects/index_#{ is_active ? 'active' : 'inactive' }"
  end

  def show
    (redirect_to :controller => 'ideas' and return) if params[:id] == 'ideen'  #HACK!
    @project = params[:slug] ? Project.find_by_slug(params[:slug], :include => :tasks) : Project.find(params[:id], :include => :tasks)
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.xml
  def create
    # TODO: sanitize params (safe attr)
    @project = Project.new(params[:project].merge(:creator => current_user))
    @project.save
    render :update do |page|
      if @project.errors.empty?
        page.redirect_to projects_path
      else
        page << "handle_form_errors('idea',['title','body'],#{@project.errors.to_hash.to_json})"
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @project = Project.find(params[:id])
    # check authorization
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @project = Project.find(params[:id])
    check_authorization @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
