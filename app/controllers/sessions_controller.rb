class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      flash[:success] ="Logged In!!"
      redirect_to user_path(current_user)
    else
      flash[:danger] ="Failed.."
      render 'new'
    end
  end

  def destroy
  end
end
