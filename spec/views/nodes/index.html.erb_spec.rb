require 'spec_helper'

describe "/nodes/index.html.erb" do
  include NodesHelper

  before(:each) do
    assigns[:nodes] = [
      stub_model(Node,
        :name => "value for name",
        :git_repo_id => 2,
        :git_repo_path => "value for git_repo_path"
      ),
      stub_model(Node,
        :name => "value for name",
        :git_repo_id => 2,
        :git_repo_path => "value for git_repo_path"
      )
    ]
  end

  it "renders a list of nodes" do
    render
    response.should have_tag("tr>td", "value for name".to_s)
    response.should have_tag("tr>td:nth-child(2)", 2)
    response.should have_tag("tr>td", "value for git_repo_path".to_s)
  end
end
