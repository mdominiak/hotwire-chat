class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show ]

  def show
    @messages = @room.messages.order(created_at: :desc)
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
