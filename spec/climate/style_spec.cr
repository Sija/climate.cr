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
  it "initializes" do
    style = build_style
    style.delimiters.should eq({'?', '¿'})
    style.keep_delimiters?.should be_false
    style.colors.should eq({
      fore: :magenta,
      back: :default,
    })
    style.decoration.should eq(:bold)
  end

  it "parses" do
    expected_parts = {
      "FOO".colorize(:magenta).mode(:bold),
    }
    build_style.parse("Does it ?FOO¿?")
      .should eq("Does it %s?" % expected_parts)
  end
end
