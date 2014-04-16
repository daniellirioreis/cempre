require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :company => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_company[name=?]", "course[company]"
      assert_select "input#course_name[name=?]", "course[name]"
    end
  end
end
