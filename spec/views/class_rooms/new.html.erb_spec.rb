require 'rails_helper'

RSpec.describe "class_rooms/new", :type => :view do
  before(:each) do
    assign(:class_room, ClassRoom.new())
  end

  it "renders new class_room form" do
    render

    assert_select "form[action=?][method=?]", class_rooms_path, "post" do
    end
  end
end
