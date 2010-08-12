When /^I create a node named "([^"]*)" based on "([^"]*)"$/ do |node_name, git_file_path|
  Node.create!(:name => node_name, :git_repo_path => git_file_path, :git_repo_id => @test_repo.id)
end

When /^I grant anonymous access to the node named "([^"]*)"$/ do |node_name|
  test_node = Node.find_by_name(node_name)
  test_node.public.should_not be true
  test_node.public = true
  test_node.save!
end

When /^I logout$/ do
  pending # express the regexp above with the code you wish you had
end
