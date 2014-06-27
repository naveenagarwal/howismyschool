require 'rails_helper'

RSpec.describe "students/show", :type => :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      :name => "Name",
      :roll_number => "Roll Number",
      :class_room => "",
      :creator => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Roll Number/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
