require 'rails_helper'

RSpec.describe "ClassRooms", :type => :request do
  describe "GET /class_rooms" do
    it "works! (now write some real specs)" do
      get class_rooms_path
      expect(response.status).to be(200)
    end
  end
end
