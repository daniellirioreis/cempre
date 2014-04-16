require 'spec_helper'

describe "classrooms/index" do
  before(:each) do
    assign(:classrooms, [
      stub_model(Classroom,
        :name => "Name",
        :course => nil,
        :company => nil,
        :day_week => 1,
        :teacher => nil
      ),
      stub_model(Classroom,
        :name => "Name",
        :course => nil,
        :company => nil,
        :day_week => 1,
        :teacher => nil
      )
    ])
  end

  it "renders a list of classrooms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
