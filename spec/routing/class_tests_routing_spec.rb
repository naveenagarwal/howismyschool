require "rails_helper"

RSpec.describe ClassTestsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/class_tests").to route_to("class_tests#index")
    end

    it "routes to #new" do
      expect(:get => "/class_tests/new").to route_to("class_tests#new")
    end

    it "routes to #show" do
      expect(:get => "/class_tests/1").to route_to("class_tests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/class_tests/1/edit").to route_to("class_tests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/class_tests").to route_to("class_tests#create")
    end

    it "routes to #update" do
      expect(:put => "/class_tests/1").to route_to("class_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/class_tests/1").to route_to("class_tests#destroy", :id => "1")
    end

  end
end
