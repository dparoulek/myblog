require 'bloodhound/bloodhound'
include BloodHound

# Need to remove this
Given /^I have set up a git repository by setting path to "([^"]*)" and setting name to "([^"]*)"$/ do |path, name|
  (File.exists? File.expand_path path).should == true
  @test_repo = GitRepo.create!(:path => path, :name => name)
end

Given /^I have set up and indexed a git repository by setting path to "([^"]*)" and setting name to "([^"]*)"$/ do |path, name|
  (File.exists? File.expand_path path).should == true
  @test_repo = GitRepo.create!(:path => path, :name => name)
  reindex(@test_repo.path, {:id => @test_repo.id, :git_repo_path => @test_repo.path, :git_repo_name => @test_repo.name})  
end

Given /^that "([^"]*)" is not a valid git repository$/ do |path|
  GitRepo.find_by_name(path).should == nil
end
