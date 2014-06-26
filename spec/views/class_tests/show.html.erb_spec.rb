require 'rails_helper'

RSpec.describe "class_tests/show", :type => :view do
  before(:each) do
    @class_test = assign(:class_test, ClassTest.create!(
      :name => "Name",
      :school => nil,
      :school_branch => nil,
      :creator => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
