Given /^that I have registered an account using "([^"]*)" as username and "([^"]*)" as password$/ do |username, password|
  Person.create!(:email => username, :password => password)
  @username = username
  @password = password
end

Given /^that I am not logged in$/ do
  visit "/login"
  response.should_not contain "Logout"
end

Given /^that I am logged in$/ do
  visit "/login"
  fill_in("email", :with => @username)
  fill_in("password", :with => @password)
  click_button("Login")
  response.should contain("You are currently logged in as #{@username}")
end

Then /^I should be logged in$/ do
  visit "/login"
  response.should contain("Welcome, #{person}")
end
