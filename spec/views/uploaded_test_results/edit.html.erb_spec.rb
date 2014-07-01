require 'rails_helper'

RSpec.describe "uploaded_test_results/edit", :type => :view do
  before(:each) do
    @uploaded_test_result = assign(:uploaded_test_result, UploadedTestResult.create!())
  end

  it "renders the edit uploaded_test_result form" do
    render

    assert_select "form[action=?][method=?]", uploaded_test_result_path(@uploaded_test_result), "post" do
    end
  end
end
