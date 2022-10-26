class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show ]

  def show
    @messages = @room.messages
      .includes(:author)
      .limit(500)
      .order(created_at: :desc)
      .reverse

    @new_message = Message.new(room: @room)
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
