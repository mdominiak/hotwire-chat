# Hotwire Chat

![rspec](https://github.com/mdominiak/hotwire-chat/workflows/rspec/badge.svg)

Demo chat web application built in Ruby on Rails with [Hotwire](https://hotwire.dev).<br />The demo is available at: https://hotwired-chat.herokuapp.com

![Hotwire Chat Demo](public/chat.gif)

## Creating message

![create message](/public/messages_create.png)

When message form is submitted to the `POST /rooms/1/messages` endpoint, the `messages#create` controller action

```ruby
class MessagesController < ApplicationController
  def create
    @message = @room.messages.new(message_params)
    @message.author = current_user

    if @message.save
      render turbo_stream: turbo_stream.append(:messages, @message)
    else
      render 'new', layout: false, status: :unprocessable_entity
    end
  end
end
```

returns the following response:

```html
<turbo-frame action="append" target="messages">
  <fragment>
     <!-- app/views/messages/_message.html.erb partial -->
    <turbo-frame id="message_123" ...>
      ...
    </turbo-frame>
  </fragment>
</turbo-frame>
```

which is turbo stream action appending created message html fragment to `#messages` container element. DOM updates are automatically handled by Turbo javascript on client side.

### Broadacasting created message

## Editing message

## Updating message

### Broadcasting updated message

## Canceling message edit

## Deleting message

### Broadcasting deleted message

# Testing
