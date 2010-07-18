require 'spec_helper'

describe LoginController do
  fixtures :people 

  it "logs a user in" do
    request.env["HTTP_REFERER"] = "/login"
    post :login, :email => 'test@email.com', :password => 'test'
    flash[:notice].should == "Logged In Successfully!"
    session[:person].email.should == "test@email.com"
  end
  
  it "should not be able to login via get"

end
