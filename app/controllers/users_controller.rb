class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  skip_before_filter :verify_authenticity_token
  
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    if !params[:user][:district].blank? && params[:user][:district] != 'other'
      @user.town_id = params[:user][:district]
    end
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      render :update do |page|
        page << "Signup.restore();"
      end
      Notifier.deliver_signup_thanks(@user, @user.password)
      
      # TODO if users in constituency are now >3, send email to all candidates in this area that have email addresses (if any)
      # email should maybe include list of all currently signed up users emails in this area
      
      #redirect_back_or_default('/')
    else
      # convert errors into json that we'll parse on the client side
      render :update do |page|
        errs = @user.errors.to_hash
        if params[:user][:district] == 'wien' || (params[:user][:district].blank? && (params[:user][:town].downcase.strip == 'wien'))
          errs[:town] = "- Bezirk auswählen"
          page << "Map.toggle_vienna_dropdown(true);"
        end
        page << "Signup.handle_form_errors(#{errs.to_json})"
      end
    end
  end
  
  def deleteme
    if logged_in? && request.post?
      @deleted = true
      current_user.destroy
      reset_session
    else
      @render_signup_overlay = true
    end
  end
  
  def autocomplete_town
    # beginning with
    find_options = { 
      :conditions => [ "LOWER(name) LIKE ?", params[:user][:town].downcase + '%' ], 
      :order => "name ASC"
    }
    @items = Town.find(:all,find_options)
    
    find_options.merge!({
        :conditions => [ "LOWER(name) LIKE ?", '%' + params[:user][:town].downcase + '%' ]
    })
    
    @items += (Town.find(:all,find_options) - @items)
    @items.collisions(&:name).values.each {|is| is.each { |i| i.name += " (#{i.constituency.name})"}}
    
    @items -= Town.vienna_districts
    @items  = @items.first(20)
    
    render :inline => "<%= auto_complete_result @items, 'name' %>"
  end
end
