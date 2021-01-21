require 'rails_helper'

describe "edit message", type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome)
  end

  let!(:user) { User.create(name: 'matt') }
  let!(:message) { Message.create(room: Room.default_room, author: user, content: 'v1')}

  it "updates and shows message" do
    log_in(user.name)

    within "#message_#{message.id}" do
      expect(page).to have_content 'v1'
      expect(page).to_not have_content 'edit'

      find('.formatted-content').hover
      click_on 'edit'
      expect(page).to_not have_content 'v1'
      fill_in "message[content]", with: 'v2'
      click_on 'Save changes'

      expect(page).to have_content 'v2'
      expect(page).to have_content 'edited'
      expect(page).to_not have_content 'v1'
      expect(message.reload.content).to eq 'v2'

      # edit and cancel
      find('.formatted-content').hover
      click_on 'edit'
      expect(page).to_not have_content 'v2'
      fill_in "message[content]", with: 'v3'
      click_on 'Cancel'
      expect(page).to have_content 'v2'
    end
  end
end
