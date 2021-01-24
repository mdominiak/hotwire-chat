module TurboStreamSpecSupport
  def turbo_stream_headers(headers={})
    headers.merge('Accept': %i[ turbo_stream html ].map{ |type| Mime[type].to_s }.join(', '))
  end
end
