require 'rails_helper'

RSpec.describe 'submit join form', type: :request do
  let(:user_params) { { name: 'matt' } }
  let(:params) { { user: user_params } }
  subject { post join_path, params: params }

  it 'creates user' do
    expect { subject }.to change { User.count }
    User.last.tap { |user| expect(user.name).to eq user_params[:name] }
  end

  it 'logs in user' do
    subject
    expect(session[:current_user_id]).to eq User.last.id
  end

  it 'redirects to default room' do
    subject
    expect(response).to redirect_to Room.default_room
  end

  context 'when invalid user param is submitted' do
    before { user_params[:name] = '' }

    it 'renders form with error message' do
      subject
      expect(response).to have_http_status(422)
    end
  end

  context 'when user exists' do
    let!(:user) { User.create!(name: user_params[:name]) }

    it 'does not create new user' do
      expect { subject }.to_not change { User.count }
    end

    it 'logs in existing user' do
      subject
      expect(session[:current_user_id]).to eq user.id
    end

    it 'redirects to default room' do
      subject
      expect(response).to redirect_to Room.default_room
    end  
  end
end
