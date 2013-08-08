require "spec_helper"

describe EpisodesController do
  describe "routing" do

    it "routes to #index" do
      get("/episodes").should route_to("episodes#index")
    end

    it "routes to #new" do
      get("/episodes/new").should route_to("episodes#new")
    end

    it "routes to #show" do
      get("/episodes/1").should route_to("episodes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/episodes/1/edit").should route_to("episodes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/episodes").should route_to("episodes#create")
    end

    it "routes to #update" do
      put("/episodes/1").should route_to("episodes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/episodes/1").should route_to("episodes#destroy", :id => "1")
    end

  end
end
