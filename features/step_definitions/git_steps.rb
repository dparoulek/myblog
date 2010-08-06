Given /^I have set up a git repository inside "([^"]*)"$/ do |path|
  (File.exists? File.expand_path path).should == true
  @notes = GitRepo.create!(:path => path, :name => "notes")
end

Given /^that "([^"]*)" is not a valid git repository$/ do |path|
  GitRepo.find_by_name(path).should == nil
end
