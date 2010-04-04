# methods that both ideas and reasons controllers should have.
module CommonWisdom
  def rate_up
    wisdom = (self.class == IdeasController ? Idea : Reason).find(params[:id])
    @user.rate_up(wisdom)
    respond_to do |format|
      format.html { render :text => "ok"}
      format.xml  { render :xml => @ideas }
    end
  end
  
  def rate_down
    respond_to do |format|
      wisdom = (self.class == IdeasController ? Idea : Reason).find(params[:id])
      @user.rate_down(wisdom)
      format.html { render :text => "ok"}
      format.xml  { render :xml => @ideas }
    end
  end
end