require "../spec_helper"

describe Climate::Style do
  it "initializes" do
    style = Climate::Style.new(
      delimiters: {'?', '¿'},
      keep_delimiters: false,
      colors: {
        fore: :magenta,
        back: :default,
      },
      decoration: :bold
    )
    style.delimiters.should eq({'?', '¿'})
    style.keep_delimiters?.should be_false
    style.colors.should eq({
      fore: :magenta,
      back: :default,
    })
    style.decoration.should eq(:bold)
  end
end
