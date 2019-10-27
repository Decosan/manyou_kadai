class ContactMailer < ApplicationMailer
  def contact_mail(user)
    @user = user

    mail to: user.email, subject: "期限が間近となっているタスクのお知らせ"
  end
end
