require "rails_helper"

RSpec.describe LookUpsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/look_ups").to route_to("look_ups#index")
    end

    it "routes to #new" do
      expect(:get => "/look_ups/new").to route_to("look_ups#new")
    end

    it "routes to #show" do
      expect(:get => "/look_ups/1").to route_to("look_ups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/look_ups/1/edit").to route_to("look_ups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/look_ups").to route_to("look_ups#create")
    end

    it "routes to #update" do
      expect(:put => "/look_ups/1").to route_to("look_ups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/look_ups/1").to route_to("look_ups#destroy", :id => "1")
    end

  end
end
