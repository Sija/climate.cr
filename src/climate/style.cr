module Climate
  struct Style
    getter delimiters : {Char, Char}
    getter? keep_delimiters : Bool
    getter colors : NamedTuple(
      fore: Colorize::Color | Symbol,
      back: Colorize::Color | Symbol,
    )?
    getter decoration : Colorize::Mode?

    def initialize(@delimiters, @keep_delimiters, @colors = nil, decoration = nil)
      unless @colors || decoration
        raise ArgumentError.new("Need to specify either colors or decoration")
      end
      if @delimiters.any? { |char| char.alphanumeric? || char.whitespace? }
        raise ArgumentError.new("Cannot use alphanumeric or whitespace delimiters")
      end
      if decoration
        @decoration = Colorize::Mode.parse(decoration.to_s)
      end
    end

    protected getter pattern : Regex do
      opening, closing = delimiters
      Regex.new(
        "\\#{opening}(?<value>[^\\#{closing}\\s]+)\\#{closing}"
      )
    end

    def parse(message : String) : String
      opening, closing = delimiters
      message.gsub(pattern) do |_, match|
        value = match["value"].colorize
        if colors = self.colors
          value = value
            .fore(colors[:fore] || :default)
            .back(colors[:back] || :default)
        end
        if decoration = self.decoration
          value = value.mode(decoration)
        end
        next "#{opening}#{value}#{closing}" if keep_delimiters?
        value
      end
    end

    def strip(message : String, *, force = false) : String
      opening, closing = delimiters
      message.gsub(pattern) do |_, match|
        value = match["value"]
        next value if force
        next "#{opening}#{value}#{closing}" if keep_delimiters?
        value
      end
    end
  end
end
