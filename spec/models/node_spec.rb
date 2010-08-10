require 'spec_helper'

describe Node do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :path => "value for path",
      :contents => "value for contents"
    }

    @mkdwn_attributes = {
      :name => "test.mkdwn",
      :path => "cooking",
      :contents => "### Header 3

Just a regular paragraph"
    }

    @org_attributes = {
      :name => "test.org",
      :path => "/",
      :contents => "* Todo Item 1"
    }
  end

  it "should create a new instance given valid attributes" do
    Node.create!(@valid_attributes)
  end

  it "should convert markdown to html" do 
    mkdwn_node = Node.create!(@mkdwn_attributes)
    mkdwn_node.to_html.should include "<h3>Header 3</h3>"
  end

  it "should convert org to html" do
    org_node = Node.create!(@org_attributes)
    org_node.to_html.should include "<h1 class=\"title\">Todo Item 1</h1>"
  end
end

# == Schema Information
#
# Table name: nodes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  path       :string(255)
#  contents   :text
#  created_at :datetime
#  updated_at :datetime
#

