class IdeasController < ApplicationController
  before_filter :login_required, :only => [:new, :vote_up, :vote_down, :create, :update, :edit, :destroy, :create]
  
  def vote_up
    vote(1)
  end
  
  def vote_down
    vote(-1)
  end
  
  def vote(pts)
    @idea = Idea.find(params[:id])
    @idea.vote!(current_user,pts)
    render :update do |page|
      page.replace "idea_#{@idea.id}_rating", :partial => 'rating', :locals => {:idea => @idea}
      page.visual_effect :highlight, "idea_#{@idea.id}" 
    end
  end
  
  # GET /ideas
  # GET /ideas.xml
  def index
    @render_signup_overlay = true
    @ideas = Idea.find(:all,:order => 'score DESC', :include => :author)
  end

  # GET /ideas/1
  def show
    @render_signup_overlay = true
    @idea = Idea.find(params[:id])
  end

  # GET /ideas/new
  # GET /ideas/new.xml
  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.xml
  def create
    # TODO: sanitize params (safe attr)
    @idea = Idea.new(params[:idea].merge(:author => current_user))
    @idea.save
    render :update do |page|
      if @idea.errors.empty?
        page.redirect_to ideas_path
      else
        page << "handle_form_errors('idea',['title','body'],#{@idea.errors.to_hash.to_json})"
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.xml
  def update
    @idea = Idea.find(params[:id])
    check_authorization @idea
    @idea.update_attributes(params[:idea])
    redirect_to(@idea)
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.xml
  def destroy
    @idea = Idea.find(params[:id])
    check_authorization @idea
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
    end
  end
end
