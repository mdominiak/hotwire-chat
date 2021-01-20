require 'rails_helper'

describe "send message", type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome)
  end

  let!(:user) { User.create(name: 'matt') }

  it "creates and shows message" do
    log_in(user.name)

    fill_in 'Message #general', with: "**Hotwire** in action :tada:\n"
    expect {
      within('#messages') do
        expect(page).to have_content 'Hotwire in action 🎉', count: 1
        expect(page).to have_css 'strong', text: 'Hotwire', count: 1
      end
    }.to change { Message.count }  
  end
end
