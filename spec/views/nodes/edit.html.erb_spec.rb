require 'spec_helper'

describe "/nodes/edit.html.erb" do
  include NodesHelper

  before(:each) do
    assigns[:node] = @node = stub_model(Node,
      :new_record? => false,
      :name => "value for name",
      :git_repo_id => "value for git_repo_id",
      :git_repo_path => "value for git_repo_path"
    )
  end

  it "renders the edit node form" do
    render

    response.should have_tag("form[action=#{node_path(@node)}][method=post]") do
      with_tag('input#node_name[name=?]', "node[name]")
      with_tag('input#node_git_repo_id[name=?]', "node[git_repo_id]")
      with_tag('input#node_git_repo_path[name=?]', "node[git_repo_path]")
    end
  end
end
