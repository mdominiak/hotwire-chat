require 'rails_helper'

describe 'messages#update', type: :request do
  let!(:author) { User.create(name: 'matt') }
  let!(:current_user) { log_in(author.name) }
  let!(:message) { Message.create!(room: Room.default_room, author: author, content: 'v1') }

  let(:message_params) { { content: 'v2' } }
  subject { patch message_path(message.id), headers: turbo_stream_headers, params: { message: message_params } }

  it 'updates message' do
    subject
    expect(message.reload.content).to eq message_params[:content]
  end

  it 'returns message turbo frame' do
    subject

    expect(response).to have_http_status(200)
    assert_select('body', 0)
    assert_select("turbo-frame#message_#{message.id}", 1)
    assert_select(".formatted-content", text: 'v2', count: 1)
  end

  context 'when invalid params' do
    before { message_params[:content] = '' }

    it 'responds with 422' do
      subject
      expect(response).to have_http_status(422)
    end
  end

  context 'when unauthorized' do
    let!(:current_user) { log_in('unauthorized') }

    it 'responds with forbidden' do
      subject
      expect(response).to have_http_status(403)
    end
  end

  context 'when unauthenticated' do
    let!(:current_user) { nil }

    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end
end
