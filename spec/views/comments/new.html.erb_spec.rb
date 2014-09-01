require 'rails_helper'

RSpec.describe "comments/new", :type => :view do
  before(:each) do
    assign(:comment, Comment.new(
      :description => "MyText",
      :comentator => nil,
      :comment_for => nil
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "textarea#comment_description[name=?]", "comment[description]"

      assert_select "input#comment_comentator_id[name=?]", "comment[comentator_id]"

      assert_select "input#comment_comment_for_id[name=?]", "comment[comment_for_id]"
    end
  end
end
