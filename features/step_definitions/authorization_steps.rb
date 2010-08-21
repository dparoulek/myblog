When /^I create a node named "([^"]*)" based on "([^"]*)"$/ do |node_name, git_file_path|
  @test_node = Node.create!(:name => node_name, :git_repo_path => git_file_path, :git_repo_id => @test_repo.id, :public=>true)
end

Given /^I set the published_on to "([^"]*)"$/ do |date|
  dt = DateTime.parse(date)   
  @test_node.publish_date = dt
  @test_node.save!
end
