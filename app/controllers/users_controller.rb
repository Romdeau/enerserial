class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def set_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, true
    if @user.save
      redirect_to user_registration_path, notice: "User set to admin status"
    else
      redirect_to user_registration_path, alter: "something went wrong!"
    end
  end
end
