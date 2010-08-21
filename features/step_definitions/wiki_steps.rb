Given /^I created nodes using$/ do |node_table|
  # table is a Cucumber::Ast::Table
  node_table.hashes.each do |hash|
    Node.create(hash)
  end
end

Given /^I set number of nodes to display on a page to "([^"]*)"$/ do |per_page|
  Node.per_page = per_page.to_i
end

When /^I save and open page$/ do
  save_and_open_page
end


