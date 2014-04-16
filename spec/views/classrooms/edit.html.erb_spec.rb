require 'spec_helper'

describe "classrooms/edit" do
  before(:each) do
    @classroom = assign(:classroom, stub_model(Classroom,
      :name => "MyString",
      :course => nil,
      :company => nil,
      :day_week => 1,
      :teacher => nil
    ))
  end

  it "renders the edit classroom form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", classroom_path(@classroom), "post" do
      assert_select "input#classroom_name[name=?]", "classroom[name]"
      assert_select "input#classroom_course[name=?]", "classroom[course]"
      assert_select "input#classroom_company[name=?]", "classroom[company]"
      assert_select "input#classroom_day_week[name=?]", "classroom[day_week]"
      assert_select "input#classroom_teacher[name=?]", "classroom[teacher]"
    end
  end
end
