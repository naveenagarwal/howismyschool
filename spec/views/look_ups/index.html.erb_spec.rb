require 'rails_helper'

RSpec.describe "look_ups/index", :type => :view do
  before(:each) do
    assign(:look_ups, [
      LookUp.create!(),
      LookUp.create!()
    ])
  end

  it "renders a list of look_ups" do
    render
  end
end
