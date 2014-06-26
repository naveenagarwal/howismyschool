require 'rails_helper'

RSpec.describe "ClassTests", :type => :request do
  describe "GET /class_tests" do
    it "works! (now write some real specs)" do
      get class_tests_path
      expect(response.status).to be(200)
    end
  end
end
