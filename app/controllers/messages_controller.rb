class MessagesController < ApplicationController
  before_action :set_room, only: %i[ create ]

  def create
    @message = @room.messages.new(message_params)
    @message.author = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream { render turbo_stream: turbo_stream.append(:messages, @message) }
      else
        format.html { render 'new', layout: false, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
