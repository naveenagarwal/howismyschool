require 'rails_helper'

RSpec.describe "class_tests/index", :type => :view do
  before(:each) do
    assign(:class_tests, [
      ClassTest.create!(
        :name => "Name",
        :school => nil,
        :school_branch => nil,
        :creator => nil
      ),
      ClassTest.create!(
        :name => "Name",
        :school => nil,
        :school_branch => nil,
        :creator => nil
      )
    ])
  end

  it "renders a list of class_tests" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
