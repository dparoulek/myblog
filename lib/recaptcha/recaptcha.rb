require 'net/http'
require 'uri'

module Recaptcha
  def validate_captcha(private_key, remote_ip, recaptcha_challenge_field, recaptcha_response_field)
    site = "http://www.google.com/recaptcha/api/verify"
    url = URI.parse(site)
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({'privatekey' => private_key, 
                        'remoteip' => remote_ip, 
                        'challenge' => recaptcha_challenge_field, 
                        'response' => recaptcha_response_field})
    h = Net::HTTP.new(url.host, url.port)
    # h.set_debug_output $stderr
    res = h.start { |http| http.request(req) }

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      success, message = res.body.split.map { |s| s.chomp }
      success = success =~ /^true$/i ? true : false
      message = message =~ /^incorrect-captcha-sol$/ ? "Oops, the text you entered doesn't match the image exactly, please try again" : message
      result = { 'success' => success, 'message' => message }
    else
      result = { 'success' => false, 'message' => res.error! }
    end
  end  
end
