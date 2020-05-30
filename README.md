# climate.cr [![Build Status](https://travis-ci.com/Sija/climate.cr.svg?branch=master)](https://travis-ci.com/Sija/climate.cr) [![Releases](https://img.shields.io/github/release/Sija/climate.cr.svg)](https://github.com/Sija/climate.cr/releases) [![License](https://img.shields.io/github/license/Sija/climate.cr.svg)](https://github.com/Sija/climate.cr/blob/master/LICENSE)

Small helper utility to make your CLI program output 🌈 coloured by means
of configurable markup styles. Think of it as your CLI-mate :)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     climate:
       github: Sija/climate.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "climate"

message = "Usage: {#{PROGRAM_NAME}} <required-arg> [optional-arg]"

# you can call `Climate.parse` method directly
puts Climate.parse(message)

# or use a `String#climatize` extension
puts message.climatize
```

### Defaults

Default styles are:

- `<>` colored in _green_ (keeping delimiters)
- `[]` colored in _yellow_ (keeping delimiters)
- `{}` colored in _blue_ (hiding delimiters)
- `!¡` colored in _red_ (hiding delimiters)

### Configuration

You can change the global settings with a `#configure` block:

```crystal
Climate.configure do |settings|
  # use defaults
  settings.use_defaults!

  # and/or configure your own styles
  settings.styles << Climate::Style.new(
    delimiters: {'?', '¿'},
    keep_delimiters: false,
    colors: {
      fore: :magenta,
      back: :default,
    },
    decoration: :bold
  )
end
```

For the `colors` and `decoration` reference values see
documentation for the [`Colorize`](https://crystal-lang.org/api/Colorize.html)
module (which `Climate` uses under the hood).

## Contributing

1. Fork it (<https://github.com/Sija/climate.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Sijawusz Pur Rahnama](https://github.com/Sija) - creator and maintainer
