require 'rails_helper'

RSpec.describe "visit join page", type: :request do
  subject { get join_path }

  it 'responds with success' do
    subject
    expect(response).to have_http_status(200)
  end
end
