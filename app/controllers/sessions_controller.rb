class SessionsController < ApplicationController
  def new
    redirect_to teams_path if Current.user.present?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to teams_path
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end
end
