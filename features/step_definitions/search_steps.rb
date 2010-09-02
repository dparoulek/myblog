When /^I search for "([^"]*)"$/ do |phrase|
  fill_in("search", :with => phrase)
  click_button("go")
end
