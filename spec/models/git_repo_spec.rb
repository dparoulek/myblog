require 'spec_helper'

describe GitRepo do
  before(:each) do
    @valid_attributes = {
      :path => "value for path"
    }
  end

  it "should expand ~ into home directory path" do
    repo = GitRepo.create!(:path => "~/notes")
    repo.path.should == "/Users/dparoulek/notes"
  end

  it "should create a new instance given valid attributes" do
    GitRepo.create!(@valid_attributes)
  end
end

# == Schema Information
#
# Table name: git_repos
#
#  id         :integer         not null, primary key
#  path       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

