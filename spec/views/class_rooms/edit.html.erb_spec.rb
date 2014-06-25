require 'rails_helper'

RSpec.describe "class_rooms/edit", :type => :view do
  before(:each) do
    @class_room = assign(:class_room, ClassRoom.create!())
  end

  it "renders the edit class_room form" do
    render

    assert_select "form[action=?][method=?]", class_room_path(@class_room), "post" do
    end
  end
end
