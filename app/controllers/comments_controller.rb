class CommentsController < ApplicationController
  before_filter :find_models
  before_filter :login_required
  
  def create
    comment = Comment.new(params[:comment])
    comment.user_id = current_user.id
    
    if params[:constituency_id]
      comment.constituency_id = params[:constituency_id]
      @parent = comment.constituency
      # TODO: Send email notification to others in this Constituency
    elsif params[:idea_id]
      comment.idea_id = params[:idea_id]
      @parent = comment.idea
    elsif params[:question_id]
      comment.question_id = params[:question_id]
      @parent = comment.question
    elsif params[:task_id]
      comment.task_id = params[:task_id]
      @parent = comment.task
    elsif params[:project_id]
      comment.project_id = params[:project_id]
      @parent = comment.project
    end
    comment.save!
    redirect_to(request.referer || @parent)
  end
  
  def update
    @comment.update_attributes(params[:comment]) if @comment.author == current_user
    redirect_to(request.referer || @parent)
  end
  
  def destroy
    raise "Permission denied" unless logged_in? && current_user.is_admin
    @comment.destroy
    redirect_to(request.referer)
  end
protected
  def find_models
    @comment = Comment.find(params[:id]) if params[:id]
  end
end
