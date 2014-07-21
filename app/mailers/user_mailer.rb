class UserMailer < ActionMailer::Base

  helper :application
  default from: "EnerSerial@eneraque.com"

  def update_pm(user, stock, current_user)
    @user = user
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    @stock = stock
    @current_user = current_user
    mail(to: @user.email, subject: "You've been assigned PM of a Serial Number Register item.")
  end

  def status_update(user, stock, current_user)
    @user = user
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    @stock = stock
    @current_user = current_user
    mail(to: @user.email, subject: "Stock Item has been marked as On The Water.")
  end

end
