namespace :expired_announcement do
  desc "アナウンスメールの送信"
  task mail: :environment do
    User.all.each do |user|
      ContactMailer.contact_mail(user).deliver
    end
  end
end
