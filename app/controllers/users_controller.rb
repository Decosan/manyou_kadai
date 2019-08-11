class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:show]
  before_action :correct_user, only:[:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ='Signed up!!'
      log_in @user
      redirect_to @user
    else
      flash[:danger] ='Failed..'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to new_session_path
    end
  end
end
