require 'spec_helper'

describe "groups/edit" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :student => nil,
      :classroom => nil,
      :status => 1
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", group_path(@group), "post" do
      assert_select "input#group_student[name=?]", "group[student]"
      assert_select "input#group_classroom[name=?]", "group[classroom]"
      assert_select "input#group_status[name=?]", "group[status]"
    end
  end
end
