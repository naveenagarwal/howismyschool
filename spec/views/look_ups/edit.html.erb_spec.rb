require 'rails_helper'

RSpec.describe "look_ups/edit", :type => :view do
  before(:each) do
    @look_up = assign(:look_up, LookUp.create!())
  end

  it "renders the edit look_up form" do
    render

    assert_select "form[action=?][method=?]", look_up_path(@look_up), "post" do
    end
  end
end
