class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def profile
  end

  def edit
  end

  def update
    user_update_params = user_params

    if user_update_params[:password].empty?
      user_update_params.delete(:password)
      user_update_params.delete(:password_confirmation)
    end

    if @user.update(user_update_params)
      redirect_to profile_path, notice: 'Профиль успешно отредактироан!'
    else
      render :edit
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :about, :password, :password_confirmation)
    end
end
