class MessagesController < ApplicationController
  before_action :set_room, only: %i[ create ]
  before_action :set_message, only: %i[ update edit destroy show ]
  before_action :authorize_message, except: %i[ create ]

  def create
    @message = @room.messages.new(message_params)
    @message.author = current_user

    if @message.save
      Bot::RespondToCommandJob.set(wait: 1.second).perform_later(@message)

      render turbo_stream: turbo_stream.append(:messages, @message)
    else
      render 'new', layout: false, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      render @message
    else
      render 'edit', layout: false, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @message.destroy
  end

  def show
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def authorize_message
    authorize @message
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
