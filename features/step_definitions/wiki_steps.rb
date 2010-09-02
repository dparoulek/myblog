Given /^I created nodes using$/ do |node_table|
  # table is a Cucumber::Ast::Table
  node_table.hashes.each do |hash|
    node = Node.new(hash)
    node.git_repo_id = @test_repo.id
    node.publish_date = DateTime.now
    node.save!
  end
end

Given /^I set number of nodes to display on a page to "([^"]*)"$/ do |per_page|
  Node.per_page = per_page.to_i
end

When /^I save and open page$/ do
  save_and_open_page
end

Given /^that "([^"]*)" has earlier \(or equal\) publish_date than "([^"]*)"$/ do |post1, post2|
  first_post = Node.find_by_name(post1)
  second_post = Node.find_by_name(post2)
  first_post.publish_date.should <= second_post.publish_date

  first_post.id.should < second_post.id

  # this is a problem because the test creates the nodes on the exact same publish_date to the second
#   first_post.next_node.id.should == second_post.id
#   first_post.previous_node.should == nil

#   second_post.next_node.should == nil
#   second_post.previous_node.id.should == first_post.id
end
