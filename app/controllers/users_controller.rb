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
      redirect_to user_registration_path, alert: "something went wrong!"
    end
  end

  def edit_role
    @user = User.find(params[:id])
  end

  def update_role
    @update_params = (params[:user])
    @user = User.find(params[:id])
    if @user.update(role: @update_params[:role])
      redirect_to users_path, notice: "User role updated"
    else
      redirect_to user_path(@user), alert: "Something went wrong!"
    end
  end
end
