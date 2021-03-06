require 'spec_helper'

describe LoginController do
  fixtures :people 

  it "logs a user in" do
    controller.logged_in?.should be false
    request.env["HTTP_REFERER"] = "/login"
    post :login, :email => 'test@email.com', :password => 'test'
    flash[:notice].should == "Logged In Successfully!"
    session[:person].should_not be nil
    controller.current_user.email.should == "test@email.com"
    controller.logged_in?.should be true
  end

  describe "GET register" do
    it "sets redirect in session" do 
      controller.logged_in?.should be false
      get :register
      session[:redirect_to].should == "/login"      
    end
  end

  it "should not be able to login via get"

end
