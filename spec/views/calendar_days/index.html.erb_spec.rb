require 'spec_helper'

describe "calendar_days/index" do
  before(:each) do
    assign(:calendar_days, [
      stub_model(CalendarDay),
      stub_model(CalendarDay)
    ])
  end

  it "renders a list of calendar_days" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
