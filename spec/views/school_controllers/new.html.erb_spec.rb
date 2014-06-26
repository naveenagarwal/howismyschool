require 'rails_helper'

RSpec.describe "school_controllers/new", :type => :view do
  before(:each) do
    assign(:school_controller, SchoolController.new())
  end

  it "renders new school_controller form" do
    render

    assert_select "form[action=?][method=?]", school_controllers_path, "post" do
    end
  end
end
