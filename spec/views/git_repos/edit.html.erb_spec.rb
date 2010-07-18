require 'spec_helper'

describe "/git_repos/edit.html.erb" do
  include GitReposHelper

  before(:each) do
    assigns[:git_repo] = @git_repo = stub_model(GitRepo,
      :new_record? => false,
      :path => "value for path"
    )
  end

  it "renders the edit git_repo form" do
    render

    response.should have_tag("form[action=#{git_repo_path(@git_repo)}][method=post]") do
      with_tag('input#git_repo_path[name=?]', "git_repo[path]")
    end
  end
end
