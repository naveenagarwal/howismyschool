require 'rails_helper'

RSpec.describe "class_rooms/show", :type => :view do
  before(:each) do
    @class_room = assign(:class_room, ClassRoom.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
