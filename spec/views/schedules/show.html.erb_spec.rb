require 'rails_helper'

RSpec.describe "schedules/show", :type => :view do
  before(:each) do
    @schedule = assign(:schedule, Schedule.create!(
      :title => "Title",
      :creator => nil,
      :school_branch => nil,
      :event_for => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
