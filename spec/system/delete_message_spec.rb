require 'rails_helper'

describe "delete message", type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome)
  end

  let!(:user) { User.create(name: 'matt') }
  let!(:message) { Message.create(room: Room.default_room, author: user, content: 'hello')}

  it "deletes message" do
    log_in(user.name)

    within "#message_#{message.id}" do
      expect(page).to have_content message.content
      expect(page).to_not have_content 'delete'

      find('.formatted-content').hover
      click_on 'delete'
    end

    expect(page).to_not have_content message.content
    expect(Message.exists?(message.id)).to be_falsey
  end
end
