Given /^I have set up a git repository inside "([^"]*)"$/ do |path|
  (File.exists? File.expand_path path).should == true
  @notes = GitRepo.create!(:path => path)
end
