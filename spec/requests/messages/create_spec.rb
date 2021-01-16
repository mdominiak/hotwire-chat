require 'rails_helper'

describe 'submit message form', type: :request do
  let!(:user) { log_in('matt' )}
  let!(:room) { Room.create!(name: 'dev') }

  let(:message_params) { { content: 'hi!' } }
  subject { post room_messages_path(room_id: room.id), params: { message: message_params }, headers: turbo_stream_headers }

  it 'responds with success' do
    subject

    expect(response).to have_http_status(200)
    assert_select("turbo-stream[action='append'][target='messages']", 1)
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
