require 'rails_helper'

RSpec.describe "school_controllers/edit", :type => :view do
  before(:each) do
    @school_controller = assign(:school_controller, SchoolController.create!())
  end

  it "renders the edit school_controller form" do
    render

    assert_select "form[action=?][method=?]", school_controller_path(@school_controller), "post" do
    end
  end
end
