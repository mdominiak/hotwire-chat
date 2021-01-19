class UnicodeEmojiFilter < HTML::Pipeline::EmojiFilter
  # Override to convert ":emoji:" to raw unicode
  def emoji_image_tag(name)
    Emoji.find_by_alias(name)&.raw
  end

  # Override to not require asset_root configuration
  def validate
  end
end
