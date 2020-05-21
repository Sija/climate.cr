module Climate
  record Style,
    delimiters : {Char, Char},
    keep_delimiters : Bool,
    colors : NamedTuple(
      fore: Colorize::Color | Symbol,
      back: Colorize::Color | Symbol,
    )? = nil,
    decoration : Symbol? = nil
end
