require "rails_helper"

RSpec.describe TestResultsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_results").to route_to("test_results#index")
    end

    it "routes to #new" do
      expect(:get => "/test_results/new").to route_to("test_results#new")
    end

    it "routes to #show" do
      expect(:get => "/test_results/1").to route_to("test_results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_results/1/edit").to route_to("test_results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_results").to route_to("test_results#create")
    end

    it "routes to #update" do
      expect(:put => "/test_results/1").to route_to("test_results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_results/1").to route_to("test_results#destroy", :id => "1")
    end

  end
end
