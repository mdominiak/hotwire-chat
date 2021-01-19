require 'rails_helper'

describe 'visit room page', type: :request do
  let!(:user) { log_in('matt') }
  let!(:room) { Room.create!(name: 'dev') }

  subject { get room_path(room.id) }
  
  it 'responds with success' do
    subject
    expect(response).to have_http_status(200)
  end

  context 'when unauthenticated' do
    let!(:user) { nil }
    
    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end
end
