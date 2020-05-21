module Climate
  extend self

  DEFAULT_STYLES = {
    Style.new(
      delimiters: {'<', '>'},
      keep_delimiters: true,
      colors: {
        fore: :green,
        back: :default,
      },
    ),
    Style.new(
      delimiters: {'[', ']'},
      keep_delimiters: true,
      colors: {
        fore: :yellow,
        back: :default,
      },
    ),
    Style.new(
      delimiters: {'{', '}'},
      keep_delimiters: false,
      colors: {
        fore: :blue,
        back: :default,
      },
    ),
    Style.new(
      delimiters: {'!', '¡'},
      keep_delimiters: false,
      colors: {
        fore: :red,
        back: :default,
      },
    ),
  }

  class Settings
    property styles = [] of Style

    def use_defaults! : Nil
      styles.clear.concat(DEFAULT_STYLES)
    end
  end

  class_getter settings : Settings { Settings.new }

  def configure : Nil
    yield settings
  end
end
