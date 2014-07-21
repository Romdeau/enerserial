class UserMailer < ActionMailer::Base
  default from: "EnerSerial@eneraque.com"

  def update_pm(user, stock)
    @user = user
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    @stock = stock
    mail(to: @user.email, subject: "You've been assigned PM of a Serial Number Register item.")
  end

end
