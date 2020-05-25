module Climate
  struct Style
    getter delimiters : {Char, Char}
    getter? keep_delimiters : Bool
    getter colors : NamedTuple(
      fore: Colorize::Color | Symbol,
      back: Colorize::Color | Symbol,
    )?
    getter decoration : Symbol?

    def initialize(@delimiters, @keep_delimiters, @colors = nil, @decoration = nil)
      unless @colors || @decoration
        raise ArgumentError.new("Need to specify either colors or decoration")
      end
      if @delimiters.any? { |c| c.alphanumeric? || c.whitespace? }
        raise ArgumentError.new("Cannot use alphanumeric or whitespace delimiters")
      end
    end
  end
end
