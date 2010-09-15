require 'spec_helper'

describe Node do
  before(:each) do
    @mkdwn_attributes = {
      :name => "example mkdwn node",
      :git_repo_id => 1,
      :git_repo_path => "/path/to/mkdwn/file",
      :publish_date => Time.now
    }

    @org_attributes = {
      :name => "example org node",
      :git_repo_id => 1,
      :git_repo_path => "/path/to/org/file",
      :publish_date => Time.now
    }

  end

  it "should create a new instance given valid attributes" do
    Node.create!(@mkdwn_attributes)
  end

  it "should convert markdown to html" do 
    repo = mock_model(GitRepo)
    repo.stub(:getFileName).and_return("test.mkdwn")
    repo.stub(:getFileContents).and_return("### Header 3")
    GitRepo.stub(:find).and_return(repo)
    mkdwn_node = Node.create!(@valid_attributes)
    mkdwn_node.to_html.should include "<h3>Header 3</h3>"
  end

  it "should convert org to html" do
    repo = mock_model(GitRepo)
    repo.stub(:getFileName).and_return("test.org")
    repo.stub(:getFileContents).and_return("* Todo Item 1")
    GitRepo.stub(:find).and_return(repo)
    org_node = Node.create!(@org_attributes)
    org_node.to_html.should include "<h1 class=\"title\">Todo Item 1</h1>"
  end
end



# == Schema Information
#
# Table name: nodes
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  git_repo_path :string(255)
#  public        :boolean
#  publish_date  :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  git_repo_id   :integer
#  friendly_url  :string(255)
#

