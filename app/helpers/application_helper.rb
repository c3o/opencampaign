# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def map_box(title, postpone_loading = false)
    render :partial => 'shared/map_box', :locals => {:title => title, :postpone_loading => postpone_loading}
  end

  def userinfo(user)
    if user
      out = h(user.name)
      if user.is_official
        out << '<span class="user_official">Team Armin Soyka</span>'
      end
    else
      out = (controller.controller_name == 'questions') ? "Anonym" : "Gelöschter Benutzer"
    end
    out
  end
  
  def avatar(user, size=nil)
    sizeparam = size ? "#{size}x#{size}" : nil
    link_to(image_tag(user.avatar_url, :size => sizeparam, :title => user.name), user.facebook_url) if user.avatar_url
  end
  
  def comment_indicator(o, url_for_param=nil)
    if cs = o.comments.count
      link_to(cs.to_s, url_for(url_for_param || o), :class=>'comment-count')
    else
      return o.comments.count
    end
  end
  
end
