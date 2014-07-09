require 'spec_helper'

describe "classrooms/show" do
  before(:each) do
    @classroom = assign(:classroom, stub_model(Classroom,
      :name => "Name",
      :course => nil,
      :company => nil,
      :day_week => 1,
      :teacher => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
