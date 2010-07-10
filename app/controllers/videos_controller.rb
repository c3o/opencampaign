class VideosController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => 'recorded'

  def index
    @videos = Video.find(:all, :conditions => ['is_approved = ?', true], :order => 'updated_at DESC')
  end
  
  def admin
    @videos = Video.find(:all, :conditions => ['is_approved = ?', false])
  end
  
  def play
    @video = Video.find(params[:id])
  end
  
  def record
  end
  
  def recorded
    video = Video.new(:url => params[:video_url], :is_approved => false)
    video.user = current_user
    video.save
    render :text => '' and return
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
