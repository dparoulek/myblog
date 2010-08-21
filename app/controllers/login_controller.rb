class LoginController < ApplicationController
  skip_before_filter :auth_required

  def index
    flash.keep
  end

  def login
    logger.debug("Recived login request for #{params[:email]}")
    session[:return_to] = request.request_uri
    someone = Person.authenticate_by_password(params[:email], params[:password])

    flash[:notice] = "Login Invalid"
    if (someone) then
      logger.debug("Logging in #{params[:email]}")
      session[:person] = someone.id
      flash[:notice] = "Logged In Successfully!"
    end
#    render :template => "login/index"
#     redirect_to(session[:return_to] || "/")
    render :action => "index"
  end

  def logout
    session[:person]=nil
    flash[:notice] = "You logged out successfully...but you'll be back. OH YEAH, You'll be back!"
    render :template => "login/index"
  end

  # GET /register
  def register
    @person = Person.new
    session[:redirect_to] = "/login"
  end

end
