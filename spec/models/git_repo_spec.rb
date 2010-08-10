require 'spec_helper'

describe GitRepo do
  before(:each) do
    @valid_attributes = {
      :path => "/Users/test/test",
      :name => "test"
    }
  end

  it "should expand shell globs into absolute file paths" do
    repo = GitRepo.create!(:path => "~", :name => "notes")
    repo.path.should == File.expand_path("~")
    repo = GitRepo.create!(:path => "../..", :name => "notes")
    repo.path.should == File.expand_path("../..")
  end

  it "should create a new instance given valid attributes" do
    GitRepo.create!(@valid_attributes)
  end

  context "that is located at '../tmp-git-repo'" do 
    before(:each) do
      @repo = GitRepo.create!(:name => "notes", :path => File.expand_path("../tmp-git-repo"))
      @filename = "grill.mkdwn"
      @path_to_dir = "personal/cooking"
      @path_to_file = "#{@path_to_dir}/#{@filename}"
    end

    it "should distinguish between file and directory paths" do
      @repo.is_a_directory?(@path_to_dir).should == true
      @repo.is_a_file?(@path_to_file).should == true
    end
        
    it "should retrieve a directory" do
      @repo.is_a_directory?(@path_to_dir).should == true
      dir = @repo.getDirectory(@path_to_dir)
      dir.contents.should have_at_least(1).items
    end

    it "should retrieve a file" do
      @repo.is_a_file?(@path_to_file).should == true
      @repo.getFile(@path_to_file).data.should match "Debbie's famous bbq sauce"
    end

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
#  name       :string(255)
#

