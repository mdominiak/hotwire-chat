require 'rails_helper'

describe 'submit message form', type: :request do
  let!(:user) { log_in('matt' )}
  let!(:room) { Room.create!(name: 'dev') }

  let(:message_params) { { content: 'hi!' } }
  subject { post room_messages_path(room_id: room.id), params: { message: message_params } }

  it 'responds with redirect to room' do
    subject
    expect(response).to redirect_to room_url(room.id)
  end

  it 'create new message' do
    expect { subject }.to change { Message.count }
    Message.last do |tap|
      expect(message.room).to eq room
      expect(message.author).to eq user
      expect(message.content).to eq content
    end
  end

  context 'unauthenticated' do
    let!(:user) { nil }

    it 'redirects to join page' do
      subject
      expect(response).to redirect_to join_url
    end
  end
end
