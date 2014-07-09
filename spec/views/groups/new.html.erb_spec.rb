require 'spec_helper'

describe "groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :student => nil,
      :classroom => nil,
      :status => 1
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", groups_path, "post" do
      assert_select "input#group_student[name=?]", "group[student]"
      assert_select "input#group_classroom[name=?]", "group[classroom]"
      assert_select "input#group_status[name=?]", "group[status]"
    end
  end
end
