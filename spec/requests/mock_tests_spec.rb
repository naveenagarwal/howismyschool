require 'rails_helper'

RSpec.describe "MockTests", :type => :request do
  describe "GET /mock_tests" do
    it "works! (now write some real specs)" do
      get mock_tests_path
      expect(response.status).to be(200)
    end
  end
end
