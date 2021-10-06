class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit,:update, :destroy]
  before_action :check_admin
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to admin_users_path, notice: "New user create with success"
    else  
        render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Update informations with success"
    else
      render :edit
    end
  end
  def destroy
    @user.destroy
    if @user.admin
      redirect_to admin_users_path, notice: "You can't delete the last admin"
    else
      redirect_to admin_users_path, notice: "User delete with success"
    end  
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def check_admin
    unless current_user.admin
        redirect_to tasks_path, notice: "Your are not authorized to see this page"
    end
  end
end
