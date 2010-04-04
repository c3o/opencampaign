class GeoController < ApplicationController

  require 'RMagick'

  def index
    date = Time.now
    date = Time.local(date.year, date.month, date.day)
    @tasks = Task.find(:all, :order => 'created_at DESC') #todo geo targeting, activeness...
    if logged_in? && current_user.town
      @events = Event.find(:all, :conditions => ['time > ? AND constituency_id = ?', date, current_user.town.constituency.id], :order => 'time ASC', :limit => 1).each {|e| e.constituency = nil }
    end
    unless @events && !@events.empty?
      @events = Event.find(:all, :conditions => ['time > ?', date], :order => 'time ASC', :limit => 1)
    end
    
    required_user_count = 100
    current_user_count = User.count_by_sql("SELECT count(id) FROM users")
    @current_user_percent = current_user_count / (required_user_count/100)
  end
  
  def local
    @render_signup_overlay = true
    @constituency = Constituency.find(:all).detect {|c| c.url_friendly_name == params[:name].downcase}
    @events = Event.find(:all, :conditions => ['time > ? AND constituency_id = ?', Time.now, @constituency.id], :order => 'time ASC').each {|e| e.constituency = nil }
    redirect_to root_path unless @constituency
  end

  def mail
    if logged_in? && current_user.email['@'] && params[:recipient]['@']
      Notifier.deliver_pass_on(params[:recipient], current_user, params[:message])
    else
      @failed = true
    end
  end
    
  def image_overlay
	  image_types = { "image/jpeg" => 'jpg', "image/pjpeg" => 'jpg', "image/gif" => 'gif', "image/png" => 'png', "image/x-png" => 'png' }
	  
	  if request.post? && params[:image] # && valid_upload?
      random = Digest::SHA1.hexdigest("--#{Time.now.to_s}--")[0,10]
      path = "#{RAILS_ROOT}/tmp/#{random}"
      f = File.new(path, "wb")
      f.write params[:image].read
      f.close
      
      if(ext = image_types[params[:image].content_type])
        dst = Magick::Image.read(path).first
        if dst.rows > 500 || dst.columns > 500
          dst.change_geometry!('500x500') { |cols, rows, img|
            img.resize!(cols, rows)
          }
        end
        src = Magick::Image.read('public/images/buttons/diesmal-lif-gross-transparent.png').first
        geo = Magick::Geometry.new(dst.columns/1.7, dst.rows/1.7)
        src.change_geometry!(geo) { |cols, rows, img|
          img.resize!(cols, rows)
        }
        result = dst.composite(src, Magick::SouthEastGravity, Magick::OverCompositeOp)
    
        @path = "/images/uploads/#{random}.#{ext}"
        result.write("#{RAILS_ROOT}/public#{@path}")

      end

      File.delete(path)
    else
    
      # show form
      
    end
  end
  
end
