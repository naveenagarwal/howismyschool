require 'rails_helper'

RSpec.describe "test_results/new", :type => :view do
  before(:each) do
    assign(:test_result, TestResult.new(
      :percentage => 1.5,
      :grade => "MyString",
      :outcome => false,
      :remarks => "MyText",
      :subject => nil,
      :student => nil,
      :class_test => nil,
      :school_branch => nil,
      :class_room => "",
      :creator => nil
    ))
  end

  it "renders new test_result form" do
    render

    assert_select "form[action=?][method=?]", test_results_path, "post" do

      assert_select "input#test_result_percentage[name=?]", "test_result[percentage]"

      assert_select "input#test_result_grade[name=?]", "test_result[grade]"

      assert_select "input#test_result_outcome[name=?]", "test_result[outcome]"

      assert_select "textarea#test_result_remarks[name=?]", "test_result[remarks]"

      assert_select "input#test_result_subject_id[name=?]", "test_result[subject_id]"

      assert_select "input#test_result_student_id[name=?]", "test_result[student_id]"

      assert_select "input#test_result_class_test_id[name=?]", "test_result[class_test_id]"

      assert_select "input#test_result_school_branch_id[name=?]", "test_result[school_branch_id]"

      assert_select "input#test_result_class_room[name=?]", "test_result[class_room]"

      assert_select "input#test_result_creator_id[name=?]", "test_result[creator_id]"
    end
  end
end
