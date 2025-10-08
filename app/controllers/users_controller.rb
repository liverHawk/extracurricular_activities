class UsersController < ApplicationController
  before_action :authenticate_user!, except: :finish_signup

  def finish_signup
    @user = User.find(params[:id])
    if request.patch? && @user.update(user_params)
      @user.send_confirmation_instructions unless @user.confirmed?
      flash[:notice] = "You have confirmed your account successfully."
      redirect_to root_url
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to finish_signup_user_path(@user)
    end
  end

  private

  def user_params
    accessible = [:name, :email]
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end