require "spec"
require "../src/climate"

def with_clean_settings
  Climate.configure do |settings|
    settings.styles.clear
    yield settings
  end
end
