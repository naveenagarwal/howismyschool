require 'rails_helper'

RSpec.describe "schedules/new", :type => :view do
  before(:each) do
    assign(:schedule, Schedule.new(
      :title => "MyString",
      :creator => nil,
      :school_branch => nil,
      :event_for => ""
    ))
  end

  it "renders new schedule form" do
    render

    assert_select "form[action=?][method=?]", schedules_path, "post" do

      assert_select "input#schedule_title[name=?]", "schedule[title]"

      assert_select "input#schedule_creator_id[name=?]", "schedule[creator_id]"

      assert_select "input#schedule_school_branch_id[name=?]", "schedule[school_branch_id]"

      assert_select "input#schedule_event_for[name=?]", "schedule[event_for]"
    end
  end
end
