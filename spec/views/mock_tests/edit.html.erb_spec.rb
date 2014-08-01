require 'rails_helper'

RSpec.describe "mock_tests/edit", :type => :view do
  before(:each) do
    @mock_test = assign(:mock_test, MockTest.create!(
      :school_branch => nil,
      :creator => nil,
      :name => "MyString",
      :class_room => nil
    ))
  end

  it "renders the edit mock_test form" do
    render

    assert_select "form[action=?][method=?]", mock_test_path(@mock_test), "post" do

      assert_select "input#mock_test_school_branch_id[name=?]", "mock_test[school_branch_id]"

      assert_select "input#mock_test_creator_id[name=?]", "mock_test[creator_id]"

      assert_select "input#mock_test_name[name=?]", "mock_test[name]"

      assert_select "input#mock_test_class_room_id[name=?]", "mock_test[class_room_id]"
    end
  end
end
