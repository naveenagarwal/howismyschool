require 'rails_helper'

RSpec.describe "LookUps", :type => :request do
  describe "GET /look_ups" do
    it "works! (now write some real specs)" do
      get look_ups_path
      expect(response.status).to be(200)
    end
  end
end
