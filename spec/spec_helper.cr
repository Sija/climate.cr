require "spec"
require "../src/climate"

def with_clean_settings(*, use_defaults = false)
  Climate.configure do |settings|
    settings.styles.clear
    settings.use_defaults! if use_defaults
  end
  yield Climate.settings
end
