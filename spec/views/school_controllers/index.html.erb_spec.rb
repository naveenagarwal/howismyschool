require 'rails_helper'

RSpec.describe "school_controllers/index", :type => :view do
  before(:each) do
    assign(:school_controllers, [
      SchoolController.create!(),
      SchoolController.create!()
    ])
  end

  it "renders a list of school_controllers" do
    render
  end
end
