class NodesController < ApplicationController
  skip_before_filter :auth_required, :only => "show"

  # GET /nodes
  # GET /nodes.xml
  def index
    @nodes = Node.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.xml
  def show
    if(params[:path])
      path = params[:path] * '/'
      @node = Node.find_by_friendly_url(path)
    else
      @node = Node.find(params[:id])
    end
    if(@node)
      @previous_node = @node.previous_node
      @next_node = @node.next_node
    end
    @comment = Comment.new(:node_id => @node.id)
    @comment.node_id = @node.id
    @redirect_back = true

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @node }
    end
  end

  # GET /nodes/new
  # GET /nodes/new.xml
  def new
    @node = Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Node.find(params[:id])
  end

  # POST /nodes
  # POST /nodes.xml
  def create
    @node = Node.new(params[:node])
    @node.public = true

    respond_to do |format|
      if @node.save
        flash[:notice] = 'Node was successfully created.'
        format.html { 
          back_to = request.env['HTTP_REFERER'] || @node
          redirect_to(back_to) 
        }
        format.xml  { render :xml => @node, :status => :created, :location => @node }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.xml
  def update
    @node = Node.find(params[:id])

    respond_to do |format|
      if @node.update_attributes(params[:node])
        flash[:notice] = 'Node was successfully updated.'
        format.html { redirect_to(@node) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.xml
  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to(nodes_url) }
      format.xml  { head :ok }
    end
  end
end
