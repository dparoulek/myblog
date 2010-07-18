class LoginController < ApplicationController

  def index
    flash.keep
  end

  def login
    session[:return_to] = request.request_uri
    someone = Person.authenticate_by_password(params[:email], params[:password])

    flash[:notice] = "Login Invalid"
    if (someone) then
      session[:person] = someone
      flash[:notice] = "Logged In Successfully!"
    end
#    render :template => "login/index"
#     redirect_to(session[:return_to] || "/")
    render :action => "index"
  end
end
