require 'spec_helper'

describe "calendar_days/show" do
  before(:each) do
    @calendar_day = assign(:calendar_day, stub_model(CalendarDay))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
