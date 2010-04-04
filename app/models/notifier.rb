class Notifier < ActionMailer::Base
  def signup_thanks(user, password)
    @password = password
    recipients user.email
    from "LIF <dialog@lif.at>"
    subject "Diesmal LIF: Danke für deine Unterstützung!"
    body :user => user, :password => password
  end

  def pass_on(to, sender, message)
    from "#{sender.name} <#{sender.email}>"
    subject "Diesmal-LIF.at"
    recipients to
    body :sender => sender, :message => message
  end
end
