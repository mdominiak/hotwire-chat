require 'rails_helper'

describe 'logout', type: :request do
  subject { delete logout_path }

  context 'authenticated' do
    let!(:user) { log_in('matt') }

    it 'logs out current_user' do
      subject
      expect(session[:current_user_id]).to be_nil
    end

    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end

  context 'unauthenticated' do
    it 'redirects to root' do
      subject
      expect(response).to redirect_to root_url
    end
  end
end
