require 'spec_helper'

describe "/git_repos/show.html.erb" do
  include GitReposHelper
  before(:each) do
    assigns[:git_repo] = @git_repo = stub_model(GitRepo,
      :path => "value for path"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ path/)
  end
end
