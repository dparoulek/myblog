require 'spec_helper'

describe GitReposController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/git_repos" }.should route_to(:controller => "git_repos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/git_repos/new" }.should route_to(:controller => "git_repos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/git_repos/1" }.should route_to(:controller => "git_repos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/git_repos/1/edit" }.should route_to(:controller => "git_repos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/git_repos" }.should route_to(:controller => "git_repos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/git_repos/1" }.should route_to(:controller => "git_repos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/git_repos/1" }.should route_to(:controller => "git_repos", :action => "destroy", :id => "1") 
    end
  end
end
