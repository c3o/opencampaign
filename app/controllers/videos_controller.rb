class VideosController < ApplicationController
  def index
    @render_signup_overlay = true
    @videos = Video.find(:all, :conditions => ['is_approved = ?', true], :order => 'updated_at DESC')
  end
  
  def admin
    @videos = Video.find(:all, :conditions => ['is_approved = ?', false])
  end
  
  def play
    @video = Video.find(params[:id])
  end
  
  def record
    @render_signup_overlay = true
  end
  
  def WRXML
  
    @function = params[:function] || request.env["QUERY_STRING"][/action=([^&]*)&/, 1] || ''
            
    case @function
    
      when 'getMemberID'
        @user = find_user_by_session(params[:sessionGUID])  # User.find(params[:sessionGUID])
              
      when 'notifyRecordingChange'
        user = User.find(params[:memberID])
        status = params[:status]
        exists = ["true", "1"].include?(params[:exists])
        name = params[:recordingName]
        url = params[:webAccessibleURL] #.flv
        if user && status
          if status == 'new' && exists # Has recorded an unapproved video
            if video = user.video
              video.title = name
              video.url = url
              video.is_approved = false
            else
              video = Video.new(:title => name, :url => url)
              video.user = user
            end            
            video.save()
          elsif status == 'approved' # Has had his video (dis)approved
            if video = user.video
              video.is_approved = exists
              video.save()
            end
          end
        end    

    end
  
    headers["Content-Type"] = "application/xml"
    render :action => 'WRXML.xml.builder', :layout => false
  end
  
  private
  
  #def latest_video(user_id)
  #  Video.find(:first, :conditions => ['user_id = ?', user_id], :order => 'created_at DESC')
  #end
  
  def find_user_by_session(sess_id)
    return unless sess_id
    session_options = ActionController::Base.session_options
    sess = CGI::Session.new(request.cgi,{
      'session_id' => sess_id,
      'new_session' => false,
      'secret' => session_options[:secret],
      'database_manager' => session_options[:database_manager],
      'session_key' => session_options[:session_key],
      'prefix' => session_options[:prefix],
      'tmpdir' => session_options[:tmpdir],
      'cache' => session_options[:cache],
      'no_cookies' => true #undocumented ruby feature, critical for us.
    })
    if(sess[:user_id])
      User.find(sess[:user_id])
    else
      nil
    end
  end
  
end
