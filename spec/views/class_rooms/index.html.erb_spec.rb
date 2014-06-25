require 'rails_helper'

RSpec.describe "class_rooms/index", :type => :view do
  before(:each) do
    assign(:class_rooms, [
      ClassRoom.create!(),
      ClassRoom.create!()
    ])
  end

  it "renders a list of class_rooms" do
    render
  end
end
