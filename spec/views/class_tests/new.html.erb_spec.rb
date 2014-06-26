require 'rails_helper'

RSpec.describe "class_tests/new", :type => :view do
  before(:each) do
    assign(:class_test, ClassTest.new(
      :name => "MyString",
      :school => nil,
      :school_branch => nil,
      :creator => nil
    ))
  end

  it "renders new class_test form" do
    render

    assert_select "form[action=?][method=?]", class_tests_path, "post" do

      assert_select "input#class_test_name[name=?]", "class_test[name]"

      assert_select "input#class_test_school_id[name=?]", "class_test[school_id]"

      assert_select "input#class_test_school_branch_id[name=?]", "class_test[school_branch_id]"

      assert_select "input#class_test_creator_id[name=?]", "class_test[creator_id]"
    end
  end
end
