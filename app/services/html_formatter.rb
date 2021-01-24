class HtmlFormatter
  class << self
    def call(content)
      pipeline.call(content)[:output].to_s.html_safe
    end

    private 

      def pipeline
        @pipeline ||= HTML::Pipeline.new([
          HTML::Pipeline::MarkdownFilter,
          HTML::Pipeline::SanitizationFilter,
          UnicodeEmojiFilter
        ])
      end
  end
end
