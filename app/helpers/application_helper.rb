module ApplicationHelper
  def icon(icon, options = {})
    doc = Nokogiri::HTML::DocumentFragment.parse(File.read("node_modules/bootstrap-icons/icons/#{icon}.svg"))
    svg = doc.at_css("svg")

    if options[:size]
      options[:width] = options[:size]
      options[:height] = options[:size]
    end

    svg["width"] = options[:width] if options[:width]
    svg["height"] = options[:height] if options[:height]
    svg["data"] = options[:data] if options[:data]
    svg["style"] = options[:style] if options[:style]
    svg["class"] = [svg["class"], options[:class]].select(&:present?).join(" ")

    doc.to_html.html_safe
  end
end
