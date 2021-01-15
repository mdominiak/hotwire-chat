class MessagesController < ApplicationController
  before_action :set_room, only: %i[ create ]

  def create
    message = @room.messages.new(message_params)
    message.author = current_user
    message.save!

    #redirect_to @room
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
