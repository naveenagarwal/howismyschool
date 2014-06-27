require 'rails_helper'

RSpec.describe "students/new", :type => :view do
  before(:each) do
    assign(:student, Student.new(
      :name => "MyString",
      :roll_number => "MyString",
      :class_room => "",
      :creator => nil
    ))
  end

  it "renders new student form" do
    render

    assert_select "form[action=?][method=?]", students_path, "post" do

      assert_select "input#student_name[name=?]", "student[name]"

      assert_select "input#student_roll_number[name=?]", "student[roll_number]"

      assert_select "input#student_class_room[name=?]", "student[class_room]"

      assert_select "input#student_creator_id[name=?]", "student[creator_id]"
    end
  end
end
