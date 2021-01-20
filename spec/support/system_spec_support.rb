module SystemSpecSupport
  def log_in(username)
    visit root_path
    fill_in 'Enter your name', with: 'matt'
    click_on 'Join chat'
    expect(page).to have_content 'Logout', count: 1
  end
end