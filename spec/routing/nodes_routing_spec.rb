require 'spec_helper'

describe NodesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/nodes" }.should route_to(:controller => "nodes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/nodes/new" }.should route_to(:controller => "nodes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/nodes/1" }.should route_to(:controller => "nodes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/nodes/1/edit" }.should route_to(:controller => "nodes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/nodes" }.should route_to(:controller => "nodes", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/nodes/1" }.should route_to(:controller => "nodes", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/nodes/1" }.should route_to(:controller => "nodes", :action => "destroy", :id => "1") 
    end
  end
end
