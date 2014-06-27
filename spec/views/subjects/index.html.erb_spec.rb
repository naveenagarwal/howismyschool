require 'rails_helper'

RSpec.describe "subjects/index", :type => :view do
  before(:each) do
    assign(:subjects, [
      Subject.create!(
        :name => "Name",
        :school_branch => nil,
        :creator => nil
      ),
      Subject.create!(
        :name => "Name",
        :school_branch => nil,
        :creator => nil
      )
    ])
  end

  it "renders a list of subjects" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
