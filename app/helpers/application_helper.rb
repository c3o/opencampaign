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
end
