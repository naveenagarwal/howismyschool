require 'rails_helper'

RSpec.describe "uploaded_test_results/show", :type => :view do
  before(:each) do
    @uploaded_test_result = assign(:uploaded_test_result, UploadedTestResult.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
