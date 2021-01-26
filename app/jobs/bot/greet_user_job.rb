class Bot::GreetUserJob < Bot::BotJob
  def perform(user, room)
    return unless new_user?(user)

    Message.create!(
      author: bot_user,
      room: room,
      content: "Hi **#{user.name}** :wave: Thanks for checking out Hotwire Chat demo. Source code can be found here: https://github.com/mdominiak/hotwire-chat"
    )
  end

  def new_user?(user)
    !user.messages.exists?
  end
end
