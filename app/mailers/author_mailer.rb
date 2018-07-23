class AuthorMailer < ApplicationMailer
  def hello_mail(author, user)
    @author = author
    @user = user
    mail(to: user.email, subject: "Info about author #{author.fullname}")
  end
end
