require 'rails_helper'

describe 'messages#destroy', type: :request do
  let!(:author) { User.create!(name: 'matt') }
  let!(:current_user) { log_in(author.name) }
  let!(:message) { Message.create!(room: Room.default_room, author: author, content: 'hello') }

  subject { delete message_path(message), headers: turbo_stream_headers }

  it 'destroys message' do
    expect { subject }.to change { Message.count }
  end

  it 'responds with success' do
    subject
    expect(response).to have_http_status(204)
  end

  context 'when unauthenticated' do
    let!(:current_user) { nil }

    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end
end