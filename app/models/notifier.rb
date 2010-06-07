class Notifier < ActionMailer::Base
  def signup_thanks(user, password)
    @password = password
    recipients user.email
    from CONFIG['org_title']+' <'+CONFIG['contact_email']+'>'
    subject CONFIG['email_signup_subject']
    body :user => user, :password => password
  end

  def pass_on(to, sender, message)
    from "#{sender.name} <#{sender.email}>"
    subject CONFIG['email_refer_subject']
    recipients to
    body :sender => sender, :message => message
  end
end
