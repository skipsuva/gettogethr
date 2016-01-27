require "rails_helper"

RSpec.describe GatheringsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gatherings").to route_to("gatherings#index")
    end

    it "routes to #new" do
      expect(:get => "/gatherings/new").to route_to("gatherings#new")
    end

    it "routes to #show" do
      expect(:get => "/gatherings/1").to route_to("gatherings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gatherings/1/edit").to route_to("gatherings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gatherings").to route_to("gatherings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gatherings/1").to route_to("gatherings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gatherings/1").to route_to("gatherings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gatherings/1").to route_to("gatherings#destroy", :id => "1")
    end

  end
end
