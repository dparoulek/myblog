class HomeController < ApplicationController
  skip_before_filter :auth_required

  def index
    @node = Node.most_recent_node
    if(@node)
      @previous_node = @node.previous_node
      @next_node = @node.next_node

      @comment = Comment.new(:node_id => @node.id)
      @comment.node_id = @node.id
      @redirect_back = request.request_uri
    end
  end

  def latest
    # Get a list of nodes that are public to display on home page
    params[:page] = params[:page] || '1'
    @nodes = Node.most_recent_nodes(params[:page])
    @total = Node.total_published
  end
end
