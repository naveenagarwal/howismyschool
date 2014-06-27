require 'rails_helper'

RSpec.describe "test_results/index", :type => :view do
  before(:each) do
    assign(:test_results, [
      TestResult.create!(
        :percentage => 1.5,
        :grade => "Grade",
        :outcome => false,
        :remarks => "MyText",
        :subject => nil,
        :student => nil,
        :class_test => nil,
        :school_branch => nil,
        :class_room => "",
        :creator => nil
      ),
      TestResult.create!(
        :percentage => 1.5,
        :grade => "Grade",
        :outcome => false,
        :remarks => "MyText",
        :subject => nil,
        :student => nil,
        :class_test => nil,
        :school_branch => nil,
        :class_room => "",
        :creator => nil
      )
    ])
  end

  it "renders a list of test_results" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Grade".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
