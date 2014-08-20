require 'rails_helper'

RSpec.describe "look_ups/new", :type => :view do
  before(:each) do
    assign(:look_up, LookUp.new())
  end

  it "renders new look_up form" do
    render

    assert_select "form[action=?][method=?]", look_ups_path, "post" do
    end
  end
end
