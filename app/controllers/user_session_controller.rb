class UserSessionController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ new create destroy ]

  def new
    redirect_to Room.default_room if current_user
  end

  def create
    user = User.find_or_create_by(user_session_params)
    if user.persisted?
      session[:current_user_id] = user.id

      room = Room.default_room
      Bot::GreetUserJob.set(wait: 2.seconds).perform_later(user, room)

      redirect_to room
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to root_url
  end

  private

  def user_session_params
    params.require(:user).permit(:name)
  end
end
