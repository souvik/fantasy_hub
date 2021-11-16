class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to sessions_new_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def handle_invalid_record(exception)
    render :new
  end
end
