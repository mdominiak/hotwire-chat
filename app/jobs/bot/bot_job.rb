class Bot::BotJob < ApplicationJob
  queue_as :low

  def bot_user
    @user = User.find_or_create_by!(name: 'bot')
  end
end
