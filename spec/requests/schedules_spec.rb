require 'rails_helper'

RSpec.describe "Schedules", :type => :request do
  describe "GET /schedules" do
    it "works! (now write some real specs)" do
      get schedules_path
      expect(response.status).to be(200)
    end
  end
end
