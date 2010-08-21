class HomeController < ApplicationController
  skip_before_filter :auth_required

  def index
    # Get a list of nodes that are public to display on home page
    params[:page] = params[:page] || '1'
    @nodes = Node.most_recent(params[:page])
    @total = Node.total_published
  end
end
