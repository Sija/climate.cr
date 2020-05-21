require "../spec_helper"

describe Climate::Settings do
  describe "#use_defaults!" do
    it "sets default styles" do
      settings = Climate::Settings.new
      settings.use_defaults!
      settings.styles.map(&.delimiters).should eq([
        {'<', '>'},
        {'[', ']'},
        {'{', '}'},
        {'!', '¡'},
      ])
    end

    it "clears previously set styles" do
      settings = Climate::Settings.new
      settings.styles << Climate::Style.new(
        delimiters: {'?', '¿'},
        keep_delimiters: false,
        colors: {
          fore: :magenta,
          back: :default,
        },
        decoration: :bold
      )
      settings.use_defaults!
      settings.styles.map(&.delimiters).should_not contain({'?', '¿'})
    end
  end
end
