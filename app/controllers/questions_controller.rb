class QuestionsController < ApplicationController
  before_filter :login_required, :only => [:update, :edit, :destroy, :reply]
  protect_from_forgery :only => [:create, :update, :destroy] 

  def index
    @questions = Question.find(:all, :conditions => 'reply IS NOT NULL', :order => 'created_at DESC', :include => :author)
    @title = "Fragen & Antworten"
  end
  
  def reply
    return unless current_user.is_admin
    question = Question.find(params[:question_id])
    question.reply = params[:reply]
    question.reply_created = Time.now
    question.reply_updated = Time.now
    question.save
    Notifier.deliver_notification(question.author, question) if question.author 
    redirect_to question
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    # TODO: sanitize params (safe attr)
    if params[:author] == 'true'
      params[:question] = params[:question].merge(:author => current_user)
    end
    @question = Question.new(params[:question])
    @question.save
    render :update do |page|
      if @question.errors.empty?
        flash[:notice] = "Danke für deine Frage! Wir werden sie so bald wie möglich beantworten!"
        page.redirect_to questions_path
      else
        page << "handle_form_errors('question',['body'],#{@question.errors.to_hash.to_json})"
      end
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(params[:question]) if check_authorization(@question)
    redirect_to(@question)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy if check_authorization(@question)

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
