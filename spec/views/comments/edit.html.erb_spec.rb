require 'rails_helper'

RSpec.describe "comments/edit", :type => :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :description => "MyText",
      :comentator => nil,
      :comment_for => nil
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "textarea#comment_description[name=?]", "comment[description]"

      assert_select "input#comment_comentator_id[name=?]", "comment[comentator_id]"

      assert_select "input#comment_comment_for_id[name=?]", "comment[comment_for_id]"
    end
  end
end
