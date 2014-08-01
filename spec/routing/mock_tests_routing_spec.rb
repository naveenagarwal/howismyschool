require "rails_helper"

RSpec.describe MockTestsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mock_tests").to route_to("mock_tests#index")
    end

    it "routes to #new" do
      expect(:get => "/mock_tests/new").to route_to("mock_tests#new")
    end

    it "routes to #show" do
      expect(:get => "/mock_tests/1").to route_to("mock_tests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mock_tests/1/edit").to route_to("mock_tests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mock_tests").to route_to("mock_tests#create")
    end

    it "routes to #update" do
      expect(:put => "/mock_tests/1").to route_to("mock_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mock_tests/1").to route_to("mock_tests#destroy", :id => "1")
    end

  end
end
