Given /^that I have granted anonymous access to an article$/ do
  @node = Node.create(:name => "cooking.mkdwn", :git_repo_id => 1, :git_repo_path => "/path/to/file")
  @node.stub(:to_html).and_return("Some really good recipes")
  @node.chmod(777)
end

Then /^I should see the article$/ do
  pending # express the regexp above with the code you wish you had
end
