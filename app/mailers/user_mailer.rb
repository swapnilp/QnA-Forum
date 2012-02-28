class UserMailer < ActionMailer::Base
  default from: "swapnil.patil04@gmail.com"

  def email_to_owner(user, answer)
    @user = user
    @answer = answer 
    @url  = "https://accounts.google.com/ServiceLogin?service=mail&passive=true&rm=false&continue=http://mail.google.com/mail/&scc=1&ltmpl=default&ltmplcache=2"
    mail(:to => user.email, :subject => "Reply to your question")
  end
end
