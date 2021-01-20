require 'rails_helper'

describe 'user_session#new', type: :request do
  subject { get root_path }

  it 'responds with success' do
    subject
    expect(response).to have_http_status(200)
  end

  context 'when authenticated' do
    let!(:user) { log_in('matt') }

    it 'redirects to room' do
      subject
      expect(response).to redirect_to Room.default_room
    end
  end
end
