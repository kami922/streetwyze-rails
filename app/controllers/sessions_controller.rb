class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] =user.id
      redirect_to root_path, notice: "successfully logged in"
    else
      flash[:alert] = "invalid email or password"
      render :new
    end
    # debugger

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

