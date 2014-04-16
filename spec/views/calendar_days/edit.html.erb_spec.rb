require 'spec_helper'

describe "calendar_days/edit" do
  before(:each) do
    @calendar_day = assign(:calendar_day, stub_model(CalendarDay))
  end

  it "renders the edit calendar_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calendar_day_path(@calendar_day), "post" do
    end
  end
end
