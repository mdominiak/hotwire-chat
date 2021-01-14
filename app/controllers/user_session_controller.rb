class UserSessionController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by(user_session_params)
    if user.persisted?
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_session_params
    params.require(:user).permit(:name)
  end
end
