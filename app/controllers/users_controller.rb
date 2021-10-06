class UsersController < ApplicationController
  skip_before_action :login_required
  before_action :set_user, only: [:show]
  def new
    if session[:user_id].present?
      redirect_to tasks_path, notice: "Please stay on tasks page"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "Welcome #{@user.name}"
    else  
      render :new
    end
  end
  def show
    if current_user.id != @user.id
      redirect_to tasks_path
    end
  end
  private
  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
