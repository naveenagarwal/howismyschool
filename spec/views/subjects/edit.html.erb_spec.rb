require 'rails_helper'

RSpec.describe "subjects/edit", :type => :view do
  before(:each) do
    @subject = assign(:subject, Subject.create!(
      :name => "MyString",
      :school_branch => nil,
      :creator => nil
    ))
  end

  it "renders the edit subject form" do
    render

    assert_select "form[action=?][method=?]", subject_path(@subject), "post" do

      assert_select "input#subject_name[name=?]", "subject[name]"

      assert_select "input#subject_school_branch_id[name=?]", "subject[school_branch_id]"

      assert_select "input#subject_creator_id[name=?]", "subject[creator_id]"
    end
  end
end
