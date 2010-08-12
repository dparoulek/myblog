class HomeController < ApplicationController
  skip_before_filter :auth_required

  def index
    # Get a list of nodes that are public to display on home page
    @posts = Node.find(:all, :conditions => { :public => true })
  end
end
