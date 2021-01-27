class Bot::GreetUserJob < Bot::BotJob
  def perform(user, room)
    return unless new_user?(user)

    Message.create!(
      author: bot_user,
      room: room,
      content: I18n.t('bot.greet', username: user.name, bot_commands: bot_commands)
    )
  end

  def new_user?(user)
    !user.messages.exists?
  end

  def bot_commands
    Bot::RespondToCommandJob::COMMANDS.map { |command| "`!#{command}`"}.join(', ')
  end
end
