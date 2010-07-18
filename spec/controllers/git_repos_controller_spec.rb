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

end
