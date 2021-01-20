require 'rails_helper'

describe 'messages#show', type: :request do
  let!(:author) { User.create(name: 'matt') }
  let!(:current_user) { log_in(author.name) }
  let!(:message) { Message.create!(room: Room.default_room, author: author, content: 'hello') }

  let(:headers) { turbo_stream_headers.merge('Turbo-Frame': "message_#{message.id}") }
  subject { get message_path(message.id), headers: headers }

  it 'returns message turbo frame' do
    subject

    expect(response).to have_http_status(200)
    assert_select('body', 0)
    assert_select("turbo-frame#message_#{message.id}", 1)
    assert_select(".formatted-content", text: 'hello', count: 1)
  end

  context 'when unauthenticated' do
    let!(:current_user) { nil }

    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end
end
