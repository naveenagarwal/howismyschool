require 'rails_helper'

RSpec.describe "class_tests/edit", :type => :view do
  before(:each) do
    @class_test = assign(:class_test, ClassTest.create!(
      :name => "MyString",
      :school => nil,
      :school_branch => nil,
      :creator => nil
    ))
  end

  it "renders the edit class_test form" do
    render

    assert_select "form[action=?][method=?]", class_test_path(@class_test), "post" do

      assert_select "input#class_test_name[name=?]", "class_test[name]"

      assert_select "input#class_test_school_id[name=?]", "class_test[school_id]"

      assert_select "input#class_test_school_branch_id[name=?]", "class_test[school_branch_id]"

      assert_select "input#class_test_creator_id[name=?]", "class_test[creator_id]"
    end
  end
end
