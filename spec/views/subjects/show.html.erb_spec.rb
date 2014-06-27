require 'rails_helper'

RSpec.describe "subjects/show", :type => :view do
  before(:each) do
    @subject = assign(:subject, Subject.create!(
      :name => "Name",
      :school_branch => nil,
      :creator => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
