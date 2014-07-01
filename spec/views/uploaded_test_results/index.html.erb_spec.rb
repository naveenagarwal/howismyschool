require 'rails_helper'

RSpec.describe "uploaded_test_results/index", :type => :view do
  before(:each) do
    assign(:uploaded_test_results, [
      UploadedTestResult.create!(),
      UploadedTestResult.create!()
    ])
  end

  it "renders a list of uploaded_test_results" do
    render
  end
end
