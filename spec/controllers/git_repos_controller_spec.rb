require 'spec_helper'

describe GitReposController do
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
        post :create, :git_repo => {:these => 'params'}
        assigns[:git_repo].should equal(mock_git_repo)
      end

      it "redirects to the created git_repo" do
        GitRepo.stub(:new).and_return(mock_git_repo(:save => true))
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
      path = "../tmp-git-repo"
      @repo = mock_git_repo(:name => "test", :path => File.expand_path(path))
    end

    it "should list folders and files from root of git repository" do
      GitRepo.stub(:find).and_return(@repo)
      post :list, :id => 1
      assigns[:cwd].contents.collect { |entry| entry.name }.should include("todo.org")
    end

    it "should list folders and files from root of git repository by name"

    it "should map urls to git paths" do
      params_from(:get, "/notes/personal/cooking").should == {:controller => "git_repos", :action => "list", :name => "notes", :path => ["personal", "cooking"]}
      GitRepo.stub(:find_by_name).and_return(@repo)
      post :list, :name => "notes", :path => ["personal"]
      assigns[:cwd].contents.length.should >= 0
    end

    it "should redirect to home with error message when user attempts to navigate to invalid path"

    it "should branch project before editing files"

    it "should display contents of files" do
      GitRepo.stub(:find_by_name).and_return(@repo)
      post :list, :name => "notes", :path => ["personal", "cooking", "grill.mkdwn"]
      assigns[:blob].data.should include("Aunt Debbie's famous bbq sauce")
    end
  end
end
