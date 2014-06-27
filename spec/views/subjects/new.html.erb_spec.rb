require 'rails_helper'

RSpec.describe "subjects/new", :type => :view do
  before(:each) do
    assign(:subject, Subject.new(
      :name => "MyString",
      :school_branch => nil,
      :creator => nil
    ))
  end

  it "renders new subject form" do
    render

    assert_select "form[action=?][method=?]", subjects_path, "post" do

      assert_select "input#subject_name[name=?]", "subject[name]"

      assert_select "input#subject_school_branch_id[name=?]", "subject[school_branch_id]"

      assert_select "input#subject_creator_id[name=?]", "subject[creator_id]"
    end
  end
end
