require 'rails_helper'

RSpec.describe "uploaded_test_results/new", :type => :view do
  before(:each) do
    assign(:uploaded_test_result, UploadedTestResult.new())
  end

  it "renders new uploaded_test_result form" do
    render

    assert_select "form[action=?][method=?]", uploaded_test_results_path, "post" do
    end
  end
end
