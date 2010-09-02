require 'spec_helper'
require 'bloodhound/bloodhound'
include BloodHound

describe GitReposController do
  before( :each ) do
    controller.stub!(:auth_required)
  end

  def mock_git_repo(stubs={})
    @mock_git_repo ||= mock_model(GitRepo, stubs)
  end

  describe "GET index" do
    it "assigns all git_repos as @git_repos" do
      GitRepo.stub(:find).with(:all).and_return([mock_git_repo])
      get :index
      assigns[:git_repos].should == [mock_git_repo]
    end
  end

  describe "GET show" do
    it "assigns the requested git_repo as @git_repo" do
      GitRepo.stub(:find).with("37").and_return(mock_git_repo)
      get :show, :id => "37"
      assigns[:git_repo].should equal(mock_git_repo)
    end
  end

  describe "GET new" do
    it "assigns a new git_repo as @git_repo" do
      GitRepo.stub(:new).and_return(mock_git_repo)
      get :new
      assigns[:git_repo].should equal(mock_git_repo)
    end
  end

  describe "GET edit" do
    it "assigns the requested git_repo as @git_repo" do
      GitRepo.stub(:find).with("37").and_return(mock_git_repo)
      get :edit, :id => "37"
      assigns[:git_repo].should equal(mock_git_repo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created git_repo as @git_repo" do
        GitRepo.stub(:new).with({'these' => 'params'}).and_return(mock_git_repo(:save => true))
        @mock_git_repo.should_receive(:path).twice
        @mock_git_repo.should_receive(:name)
        controller.stub(:reindex).and_return(true)
        post :create, :git_repo => {:these => 'params'}
        assigns[:git_repo].should equal(mock_git_repo)
      end

      it "redirects to the created git_repo" do
        GitRepo.stub(:new).and_return(mock_git_repo(:save => true))
        @mock_git_repo.should_receive(:path).twice
        @mock_git_repo.should_receive(:name)
        controller.stub(:reindex).and_return(true)
        post :create, :git_repo => {}
        response.should redirect_to(git_repo_url(mock_git_repo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved git_repo as @git_repo" do
        GitRepo.stub(:new).with({'these' => 'params'}).and_return(mock_git_repo(:save => false))
        post :create, :git_repo => {:these => 'params'}
        assigns[:git_repo].should equal(mock_git_repo)
      end

      it "re-renders the 'new' template" do
        GitRepo.stub(:new).and_return(mock_git_repo(:save => false))
        post :create, :git_repo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested git_repo" do
        GitRepo.should_receive(:find).with("37").and_return(mock_git_repo)
        mock_git_repo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :git_repo => {:these => 'params'}
      end

      it "assigns the requested git_repo as @git_repo" do
        GitRepo.stub(:find).and_return(mock_git_repo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:git_repo].should equal(mock_git_repo)
      end

      it "redirects to the git_repo" do
        GitRepo.stub(:find).and_return(mock_git_repo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(git_repo_url(mock_git_repo))
      end
    end

    describe "with invalid params" do
      it "updates the requested git_repo" do
        GitRepo.should_receive(:find).with("37").and_return(mock_git_repo)
        mock_git_repo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :git_repo => {:these => 'params'}
      end

      it "assigns the git_repo as @git_repo" do
        GitRepo.stub(:find).and_return(mock_git_repo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:git_repo].should equal(mock_git_repo)
      end

      it "re-renders the 'edit' template" do
        GitRepo.stub(:find).and_return(mock_git_repo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested git_repo" do
      GitRepo.should_receive(:find).with("37").and_return(mock_git_repo)
      mock_git_repo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the git_repos list" do
      GitRepo.stub(:find).and_return(mock_git_repo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(git_repos_url)
    end
  end

  describe "GET list" do
    before(:each) do
      @path = "../tmp-git-repo"
      @repo =  GitRepo.create!(:name => "notes", :path => File.expand_path(@path))
    end

    it "should list folders and files from root of git repository" do
      GitRepo.stub(:find).and_return(@repo)
      post :list, :id => 1
      assigns[:files].collect { |entry| entry.name }.should include("todo.org")
    end

    it "should list folders and files from root of git repository by name" do
      params_from(:get, "/files/notes").should == {:controller => "git_repos", :action => "list", :name => "notes", :path => []}
      GitRepo.stub(:find_by_name).and_return(@repo)
      post :list, :name => "notes", :path => []
      assigns[:dirs].length.should >= 0
    end

    it "should map urls to git paths" do
      params_from(:get, "/files/notes/personal/cooking").should == {:controller => "git_repos", :action => "list", :name => "notes", :path => ["personal", "cooking"]}
      GitRepo.stub(:find_by_name).and_return(@repo)
      post :list, :name => "notes", :path => ["personal"]
      assigns[:files].length.should >= 0
    end

    it "should redirect to not_found with error message when user attempts to navigate to invalid path" do
      params_from(:get, "/files/no-where").should == {:controller => "git_repos", :action => "list", :name => "no-where", :path => []} 
      post :list, :name => "no-where", :path => []
      response.should render_template('not_found')
    end

    it "should branch project before editing files"

    it "should display contents of files" do
      post :list, :name => "notes", :path => ["personal", "cooking", "grill.mkdwn"]
      assigns[:node].to_html.should include("Aunt Debbie's famous bbq sauce")
    end
  end
end
