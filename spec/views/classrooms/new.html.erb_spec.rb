require 'spec_helper'

describe "classrooms/new" do
  before(:each) do
    assign(:classroom, stub_model(Classroom,
      :name => "MyString",
      :course => nil,
      :company => nil,
      :day_week => 1,
      :teacher => nil
    ).as_new_record)
  end

  it "renders new classroom form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", classrooms_path, "post" do
      assert_select "input#classroom_name[name=?]", "classroom[name]"
      assert_select "input#classroom_course[name=?]", "classroom[course]"
      assert_select "input#classroom_company[name=?]", "classroom[company]"
      assert_select "input#classroom_day_week[name=?]", "classroom[day_week]"
      assert_select "input#classroom_teacher[name=?]", "classroom[teacher]"
    end
  end
end
