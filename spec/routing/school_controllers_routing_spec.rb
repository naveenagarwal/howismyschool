require "rails_helper"

RSpec.describe SchoolControllersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/school_controllers").to route_to("school_controllers#index")
    end

    it "routes to #new" do
      expect(:get => "/school_controllers/new").to route_to("school_controllers#new")
    end

    it "routes to #show" do
      expect(:get => "/school_controllers/1").to route_to("school_controllers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/school_controllers/1/edit").to route_to("school_controllers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/school_controllers").to route_to("school_controllers#create")
    end

    it "routes to #update" do
      expect(:put => "/school_controllers/1").to route_to("school_controllers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/school_controllers/1").to route_to("school_controllers#destroy", :id => "1")
    end

  end
end
