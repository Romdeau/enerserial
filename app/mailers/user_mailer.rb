class UserMailer < ActionMailer::Base

  helper :application
  default from: "EnerSerial@eneraque.com"

  def update_pm(user, job, current_user)
    @user = user
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    @job = job
    @current_user = current_user
    mail(to: @user.email, subject: "You've been assigned PM of a Serial Number Register item.")
  end

  def status_update(user, stock, current_user)
    @user = user
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    @stock = stock
    @current_user = current_user
    mail(to: @user.email, subject: "Stock Item has been marked as #{@stock.status}.")
  end

  def jim_status_update(stock, current_user)
    @url = 'http://enerserial.eneraque.com/users/sign_in'
    @stock = stock
    @current_user = current_user
    mail(to: "jim.pringle@eneraque.com", subject: "Stock Item has been marked as #{@stock.status}.")
  end

  def production_notify_accounts(stock, user)
    @user = user
    @url = stock_path(stock)
    @stock = stock
    mail(to: 'luminita.kopf@eneraque.com', subject: "Stock Item Completed: Accounting Checkoff")
  end

  def production_notify_pm(stock, user)
    @user = user
    @url = stock_path(stock)
    @stock = stock
    mail(to: @stock.user.email, subject: "Stock Item Completed: PM Checkoff")
  end

end
