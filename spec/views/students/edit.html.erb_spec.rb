require 'rails_helper'

RSpec.describe "students/edit", :type => :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      :name => "MyString",
      :roll_number => "MyString",
      :class_room => "",
      :creator => nil
    ))
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(@student), "post" do

      assert_select "input#student_name[name=?]", "student[name]"

      assert_select "input#student_roll_number[name=?]", "student[roll_number]"

      assert_select "input#student_class_room[name=?]", "student[class_room]"

      assert_select "input#student_creator_id[name=?]", "student[creator_id]"
    end
  end
end
