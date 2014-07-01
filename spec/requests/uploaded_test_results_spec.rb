require 'rails_helper'

RSpec.describe "UploadedTestResults", :type => :request do
  describe "GET /uploaded_test_results" do
    it "works! (now write some real specs)" do
      get uploaded_test_results_path
      expect(response.status).to be(200)
    end
  end
end
