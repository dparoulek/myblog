# require 'guarddog/authentication'
# include GuardDog::Authentication

Given /^that I have registered an account using "([^"]*)" as username and "([^"]*)" as password$/ do |username, password|
  Person.create!(:email => username, :password => password)
  @username = username
  @password = password
end

Given /^that I am not logged in$/ do
  visit "/login"
  response.should_not contain "Logout"
end

Given /^that I am logged in$/ do |email|
  visit "/login"
  fill_in("Email", :with => @username)
  fill_in("Password", :with => @password)
  click_button("Login")
end

Then /^I should be logged in$/ do
  visit "/login"
  response.should contain("Welcome, #{person}")
end
