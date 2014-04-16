require 'spec_helper'

describe "calendar_days/new" do
  before(:each) do
    assign(:calendar_day, stub_model(CalendarDay).as_new_record)
  end

  it "renders new calendar_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calendar_days_path, "post" do
    end
  end
end
