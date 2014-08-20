require 'rails_helper'

RSpec.describe "look_ups/show", :type => :view do
  before(:each) do
    @look_up = assign(:look_up, LookUp.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
