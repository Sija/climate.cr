require "../spec_helper"

def build_style(**options)
  options = {
    delimiters:      {'?', '¿'},
    keep_delimiters: false,
    colors:          {
      fore: :magenta,
      back: :default,
    },
    decoration: :bold,
  }.merge(options)

  Climate::Style.new(**options)
end

describe Climate::Style do
  describe "#initialize" do
    it "initializes from valid values" do
      style = build_style
      style.delimiters.should eq({'?', '¿'})
      style.keep_delimiters?.should be_false
      style.colors.should eq({
        fore: :magenta,
        back: :default,
      })
      style.decoration.should eq(:bold)
    end

    it "raises when passed alphanumeric delimiters" do
      expect_raises(ArgumentError, "Cannot use alphanumeric or whitespace delimiters") do
        build_style(delimiters: {'a', '!'})
      end
      expect_raises(ArgumentError, "Cannot use alphanumeric or whitespace delimiters") do
        build_style(delimiters: {'!', 'b'})
      end
    end

    it "raises when passed whitespace delimiters" do
      expect_raises(ArgumentError, "Cannot use alphanumeric or whitespace delimiters") do
        build_style(delimiters: {' ', '!'})
      end
      expect_raises(ArgumentError, "Cannot use alphanumeric or whitespace delimiters") do
        build_style(delimiters: {'!', ' '})
      end
    end
  end

  describe "#parse" do
    context "keep_delimiters: true" do
      it "keeps delimiters" do
        expected_parts = {
          "FOO".colorize.fore(:magenta).mode(:bold),
        }
        style = build_style(keep_delimiters: true)
        style.parse("Does it ?FOO¿?")
          .should eq("Does it ?%s¿?" % expected_parts)
      end
    end

    context "keep_delimiters: false" do
      it "strips delimiters" do
        expected_parts = {
          "FOO".colorize.fore(:magenta).mode(:bold),
        }
        style = build_style(keep_delimiters: false)
        style.parse("Does it ?FOO¿?")
          .should eq("Does it %s?" % expected_parts)
      end
    end
  end
end
