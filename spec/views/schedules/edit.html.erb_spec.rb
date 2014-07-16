require 'rails_helper'

RSpec.describe "schedules/edit", :type => :view do
  before(:each) do
    @schedule = assign(:schedule, Schedule.create!(
      :title => "MyString",
      :creator => nil,
      :school_branch => nil,
      :event_for => ""
    ))
  end

  it "renders the edit schedule form" do
    render

    assert_select "form[action=?][method=?]", schedule_path(@schedule), "post" do

      assert_select "input#schedule_title[name=?]", "schedule[title]"

      assert_select "input#schedule_creator_id[name=?]", "schedule[creator_id]"

      assert_select "input#schedule_school_branch_id[name=?]", "schedule[school_branch_id]"

      assert_select "input#schedule_event_for[name=?]", "schedule[event_for]"
    end
  end
end
