require File.join(File.expand_path(File.dirname(__FILE__)), "..", "recaptcha")
include Recaptcha

## 
# its kind of a pain to test this because, by nature, a captcha
# shouldn't be able to be programmatically solved. So, to test, go to
# a page on my blog where there's a captcha, and update the
# corresponding values below from the captcha form that is generated
RECAPTCHA_PRIVATE_KEY="changeme"
REMOTE_IP="changeme"
CHALLENGE_FIELD="03AHJ_VutDZ8U0zCXYvCX6HxOh8eDIi4iJUFhCKc6gjM-VAtCETy-kPrXxGZ5FRfG8rGFKgNa6yi5MaNK786O-mw547fGKqqnl9OhI72DX7VRqXQn4xo-MQwk747voCcyMguchAO_W7x1SM9Bl3DJD0mHYrMemveRmiw"
RESPONSE_FIELD="tailling impacts"

describe Recaptcha, "#validate_captcha" do
  it "should return true when valid captcha is submitted" do
    result = validate_captcha(RECAPTCHA_PRIVATE_KEY, REMOTE_IP, CHALLENGE_FIELD, RESPONSE_FIELD)
    puts "Success: #{result['success']}, Message: #{result['message']}"
    result['success'].should be true
  end
end
