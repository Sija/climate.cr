require "./spec_helper"

describe Climate do
  describe ".configure" do
    it "yields Settings instance" do
      # ameba:disable Style/VerboseBlock
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

  it ".parse" do
    with_clean_settings(use_defaults: true) do
      expected_parts = {
        "Error".colorize.fore(:red),
        "foo".colorize.fore(:blue),
        "bar".colorize.fore(:green),
        "baz".colorize.fore(:yellow),
      }
      Climate.parse("!Error¡: {foo} <bar> [baz]")
        .should eq("%s: %s <%s> [%s]" % expected_parts)
    end
  end

  it ".strip" do
    with_clean_settings(use_defaults: true) do
      expected_parts = {"Error", "foo", "bar", "baz"}

      Climate.strip("!Error¡: {foo} <bar> [baz]")
        .should eq("%s: %s <%s> [%s]" % expected_parts)

      Climate.strip("!Error¡: {foo} <bar> [baz]", force: true)
        .should eq("%s: %s %s %s" % expected_parts)
    end
  end
end
