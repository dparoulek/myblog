require 'spec_helper'

describe "/git_repos/index.html.erb" do
  include GitReposHelper

  before(:each) do
    assigns[:git_repos] = [
      stub_model(GitRepo,
        :path => "value for path"
      ),
      stub_model(GitRepo,
        :path => "value for path"
      )
    ]
  end

  it "renders a list of git_repos" do
    render
    response.should have_tag("tr>td", "value for path".to_s, 2)
  end
end
