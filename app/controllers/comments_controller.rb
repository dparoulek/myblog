class CommentsController < ApplicationController
  skip_filter :auth_required, :only => :create

  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

    # calculate where to redirect back to
    back = @comment
    if !params[:redirect_back].blank? 
      back = params[:redirect_back]
    end

    # Check Captcha
    if RECAPTCHA_ENABLED
      @recaptcha = validate_captcha(RECAPTCHA_PRIVATE_KEY, request.remote_ip, params['recaptcha_challenge_field'], params['recaptcha_response_field'])
    else
      if ENV['captcha_result'].eql? "pass"
        @recaptcha =  {'success' => true}        
      else
        @recaptcha =  {'success' => false, 'message' => :invalid}        
      end
    end

    respond_to do |format|
      if @recaptcha && @recaptcha['success'] && @comment.save 
        flash[:notice] = "Thanks for your comment!"
        format.html { 
          redirect_to(back)
        }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        if(!@recaptcha['success'])
          @comment.errors.add('recaptcha_response_field', @recaptcha['message'])
        end
        @redirect_back = back
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
