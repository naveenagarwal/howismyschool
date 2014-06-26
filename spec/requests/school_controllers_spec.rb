require 'rails_helper'

RSpec.describe "SchoolControllers", :type => :request do
  describe "GET /school_controllers" do
    it "works! (now write some real specs)" do
      get school_controllers_path
      expect(response.status).to be(200)
    end
  end
end
