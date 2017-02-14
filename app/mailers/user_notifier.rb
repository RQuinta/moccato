class UserNotifier < ApplicationMailer

  def send_signup_email(user)
    @user = user
    mail( :to => user.email,
          :subject => 'Bem-Vindo!' )
  end

end