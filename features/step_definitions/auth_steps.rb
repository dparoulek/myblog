Given /^that I am not logged in$/ do
  current_user.is_logged_in? should be false
end

Then /^I should be logged in$/ do
  current_user.is_logged_in? should be true
end
