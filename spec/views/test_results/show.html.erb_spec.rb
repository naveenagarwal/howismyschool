require 'rails_helper'

RSpec.describe "test_results/show", :type => :view do
  before(:each) do
    @test_result = assign(:test_result, TestResult.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Grade/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
