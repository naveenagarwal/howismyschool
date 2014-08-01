require 'rails_helper'

RSpec.describe "mock_tests/show", :type => :view do
  before(:each) do
    @mock_test = assign(:mock_test, MockTest.create!(
      :school_branch => nil,
      :creator => nil,
      :name => "Name",
      :class_room => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
