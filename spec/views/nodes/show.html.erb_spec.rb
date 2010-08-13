require 'spec_helper'

describe "/nodes/show.html.erb" do
  include NodesHelper
  before(:each) do
    assigns[:node] = @node = stub_model(Node,
      :name => "value for name",
      :git_repo_id => "value for git_repo_id",
      :git_repo_path => "value for git_repo_path"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ git_repo_id/)
    response.should have_text(/value\ for\ git_repo_path/)
  end
end
