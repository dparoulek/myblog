require 'spec_helper'

describe "/git_repos/new.html.erb" do
  include GitReposHelper

  before(:each) do
    assigns[:git_repo] = stub_model(GitRepo,
      :new_record? => true,
      :path => "value for path"
    )
  end

  it "renders new git_repo form" do
    render

    response.should have_tag("form[action=?][method=post]", git_repos_path) do
      with_tag("input#git_repo_path[name=?]", "git_repo[path]")
    end
  end
end
