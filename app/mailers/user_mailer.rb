class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def update_pm(user)
    @user = user
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to EnerSerial: Serial Number Tracking')
  end

end
