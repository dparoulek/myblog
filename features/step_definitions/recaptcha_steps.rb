When /^I fill in the correct captcha$/ do
  #  This is a bit of a hack, but in comments controller, I check if
  #  RAILS_ENV is cucumber and, if so, I return
  #  session['captcha_result'] from the captcha stuff.

  ENV['captcha_result'] = "pass"
end

When /^I fill in an incorrect captcha$/ do
  #  This is a bit of a hack, but in comments controller, I check if
  #  RAILS_ENV is cucumber and, if so, I return
  #  session['captcha_result'] from the captcha stuff.

  ENV['captcha_result'] = "fail"
end
