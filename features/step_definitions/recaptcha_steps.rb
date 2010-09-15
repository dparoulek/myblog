
# Redefine validate_captcha for here
module Recaptcha
  class Recaptcha
    def self.validate_captcha
      return true
    end  
  end
end

When /^I fill in the correct captcha$/ do
#  Recaptcha::Recaptcha.stub!(:validate_captcha).and_return(true)
#   self.should_receive(:validate_captcha)
  Recaptcha::Recaptcha.validate_captcha.should be true
end
