require 'rails_helper'

describe 'messages#edit', type: :request do
  let!(:author) { User.create(name: 'matt') }
  let!(:current_user) { log_in(author.name) }
  let!(:message) { Message.create!(room: Room.default_room, author: author, content: 'hello') }

  let(:headers) { turbo_stream_headers.merge('Turbo-Frame': "message_#{message.id}") }
  subject { get edit_message_path(message.id), headers: headers }

  it 'returns turbo frame with message form' do
    subject

    expect(response).to have_http_status(200)
    assert_select('body', 0)
    assert_select("turbo-frame#message_#{message.id}", 1)
    assert_select("form[action='#{message_path(message)}']", 1)
  end

  context 'when unauthenticated' do
    let!(:current_user) { nil }

    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end
end
