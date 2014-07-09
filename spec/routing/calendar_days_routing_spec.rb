require "spec_helper"

describe CalendarDaysController do
  describe "routing" do

    it "routes to #index" do
      get("/calendar_days").should route_to("calendar_days#index")
    end

    it "routes to #new" do
      get("/calendar_days/new").should route_to("calendar_days#new")
    end

    it "routes to #show" do
      get("/calendar_days/1").should route_to("calendar_days#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calendar_days/1/edit").should route_to("calendar_days#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calendar_days").should route_to("calendar_days#create")
    end

    it "routes to #update" do
      put("/calendar_days/1").should route_to("calendar_days#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calendar_days/1").should route_to("calendar_days#destroy", :id => "1")
    end

  end
end
