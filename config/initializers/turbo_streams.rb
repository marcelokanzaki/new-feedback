module CustomTurboStreams
  def show(frame)
    %(<turbo-stream action="show" target="#{frame}"></turbo-stream>).html_safe
  end

  def hide(frame)
    %(<turbo-stream action="hide" target="#{frame}"></turbo-stream>).html_safe
  end
end

Rails.application.config.after_initialize do
  ::Turbo::Streams::TagBuilder.send :include, CustomTurboStreams
end
