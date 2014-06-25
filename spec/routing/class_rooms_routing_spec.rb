require "rails_helper"

RSpec.describe ClassRoomsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/class_rooms").to route_to("class_rooms#index")
    end

    it "routes to #new" do
      expect(:get => "/class_rooms/new").to route_to("class_rooms#new")
    end

    it "routes to #show" do
      expect(:get => "/class_rooms/1").to route_to("class_rooms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/class_rooms/1/edit").to route_to("class_rooms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/class_rooms").to route_to("class_rooms#create")
    end

    it "routes to #update" do
      expect(:put => "/class_rooms/1").to route_to("class_rooms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/class_rooms/1").to route_to("class_rooms#destroy", :id => "1")
    end

  end
end
