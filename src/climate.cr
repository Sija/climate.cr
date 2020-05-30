require "colorize"
require "./climate/*"
require "./core_ext/*"

module Climate
  extend self

  def parse(message : String) : String
    settings.styles.reduce(message) do |acc, style|
      style.parse(acc)
    end
  end
end
