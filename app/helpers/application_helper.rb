# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # redirect somewhere that will eventually return back to here
  # credit: http://ethilien.net/archives/better-redirects-in-rails/
  def redirect_away(*params)
    session[:original_uri] = request.request_uri
    redirect_to(*params)
  end

  # returns the person to either the original url from a redirect_away or to a default url
  # credit: http://ethilien.net/archives/better-redirects-in-rails/
  def redirect_back(*params)
    uri = session[:original_uri]
    session[:original_uri] = nil
    if uri
      redirect_to uri
    else
      redirect_to(*params)
    end
  end

end
