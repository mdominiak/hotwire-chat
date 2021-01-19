module MessageHelper
  def format_message_content(content)
    HtmlFormatter.call(content)
  end
end
