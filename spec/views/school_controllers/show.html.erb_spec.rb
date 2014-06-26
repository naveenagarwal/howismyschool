require 'rails_helper'

RSpec.describe "school_controllers/show", :type => :view do
  before(:each) do
    @school_controller = assign(:school_controller, SchoolController.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
