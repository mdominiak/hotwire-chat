class Bot::RespondToCommandJob < Bot::BotJob
  COMMANDS = %w[ ping hotwire ].freeze
  COMMAND_REGEXP = /\A!(?<command>#{COMMANDS.join('|')}\z)/

  def extract_bot_command(content)
    COMMAND_REGEXP.match(content)&.[](:command)
  end

  def perform(message)
    return if message.author == bot_user

    command = extract_bot_command(message.content)
    return unless command

    Message.create!(
      author: bot_user,
      content: I18n.t(command, scope: 'bot.commands', username: message.author.name),
      room: message.room
    )
  end
end
