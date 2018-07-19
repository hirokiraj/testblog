class AuthorMailer < ApplicationMailer
  def hello_mail(author, user)
    @author = author
    mail(to: user.email, subject: "Info about author #{author.fullname}")
  end
end
