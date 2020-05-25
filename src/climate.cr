require "colorize"
require "./climate/*"
require "./core_ext/*"

module Climate
  extend self

  def colorize(message : String) : String
    settings.styles.each do |style|
      opening, closing = style.delimiters
      pattern = Regex.new("\\#{opening}(?<value>[^\\#{closing}\\s]+)\\#{closing}")
      message = message.gsub(pattern) do |_, match|
        value = match["value"].colorize
        if colors = style.colors
          value = value
            .fore(colors[:fore] || :default)
            .back(colors[:back] || :default)
        end
        if decoration = style.decoration
          value = value.mode(decoration)
        end
        next "#{opening}#{value}#{closing}" if style.keep_delimiters?
        value
      end
    end
    message
  end
end
