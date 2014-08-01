require 'rails_helper'

RSpec.describe "mock_tests/index", :type => :view do
  before(:each) do
    assign(:mock_tests, [
      MockTest.create!(
        :school_branch => nil,
        :creator => nil,
        :name => "Name",
        :class_room => nil
      ),
      MockTest.create!(
        :school_branch => nil,
        :creator => nil,
        :name => "Name",
        :class_room => nil
      )
    ])
  end

  it "renders a list of mock_tests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
