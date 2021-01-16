require 'rails_helper'

RSpec.describe "chat", type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome)
  end

  it "shows sent and received messages" do
    # log in
    visit root_path
    fill_in 'Enter your name', with: 'matt'
    click_on 'Join chat'
    expect(page).to have_content '#general', count: 1

    # send message
    fill_in 'Message #general', with: "Hotwire in action!\n"
    within('#messages') do
      expect(page).to have_content 'Hotwire in action', count: 1
    end

    # receive message
    other_user = User.create!(name: 'adam')
    other_message = Message.create!(room: Room.default_room, author: other_user, content: 'Got it!')
    within('#messages') do
      expect(page).to have_content 'Got it!', count: 1
    end
  end
end
