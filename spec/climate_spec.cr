require "./spec_helper"

describe Climate do
  describe ".configure" do
    it "yields Settings instance" do
      Climate.configure do |settings|
        settings.should be_a(Climate::Settings)
      end
    end

    it "yields same Settings instance between the subsequent calls" do
      Climate.configure do |settings1|
        Climate.configure do |settings2|
          settings2.should be(settings1)
          settings2.should be(Climate.settings)
        end
      end
    end
  end

  describe ".colorize" do
    it "works with defaults" do
      with_clean_settings do |settings|
        settings.use_defaults!

        expected_parts = {
          "Error".colorize(:red),
          "foo".colorize(:blue),
          "bar".colorize(:green),
          "baz".colorize(:yellow),
        }
        Climate.colorize("!Error¡: {foo} <bar> [baz]")
          .should eq("%s: %s <%s> [%s]" % expected_parts)
      end
    end
  end
end
