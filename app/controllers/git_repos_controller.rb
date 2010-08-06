class GitReposController < ApplicationController
  def list
    #     begin
    repo = nil
    if(params[:name])
      logger.debug("Attemping to find git repo named #{params[:name]}")
      repo = GitRepo.find_by_name(params[:name])
    end

    if(params[:id])
      repo = GitRepo.find(params[:id])
    end

    unless(repo) 
      render :action => 'not_found'
      return
    end 

    # :path is present because we have a tricky catch-all route set
    # up. See the last entry in routes.rb. :path will be an array of
    # subdirs. The last entry in the :path array might be a file
    # name. '/' is actually a method on Grit:Rep that takes a path as a
    # parameter.
    if(params[:path] && !params[:path].empty?)
      abspath = params[:path] * '/'
      if(repo.is_a_file?(abspath))
        @blob = repo.getFile(abspath)
        @content = repo.convert(abspath)
        render :action => "file"          
      else 
        @cwd = repo.open(abspath)
        render :action => "list"
      end
    else
      @cwd = repo.open
      render :action => "list"
    end
    #     rescue ActiveRecord::RecordNotFound
    #       logger.error("Unable to find repository given params: #{params}")
    #       flash[:notice] = "Unable to find git repository?!"
    #       flash[:error] = $!
    #       redirect_to :action => 'not_found'
    #     end
  end

  def not_found
  end

  # GET /git_repos
  # GET /git_repos.xml
  def index
    @git_repos = GitRepo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @git_repos }
    end
  end

  # GET /git_repos/1
  # GET /git_repos/1.xml
  def show
    @git_repo = GitRepo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @git_repo }
    end
  end

  # GET /git_repos/new
  # GET /git_repos/new.xml
  def new
    @git_repo = GitRepo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @git_repo }
    end
  end

  # GET /git_repos/1/edit
  def edit
    @git_repo = GitRepo.find(params[:id])
  end

  # POST /git_repos
  # POST /git_repos.xml
  def create
    @git_repo = GitRepo.new(params[:git_repo])

    respond_to do |format|
      if @git_repo.save
        flash[:notice] = 'GitRepo was successfully created.'
        format.html { redirect_to(@git_repo) }
        format.xml  { render :xml => @git_repo, :status => :created, :location => @git_repo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @git_repo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /git_repos/1
  # PUT /git_repos/1.xml
  def update
    @git_repo = GitRepo.find(params[:id])

    respond_to do |format|
      if @git_repo.update_attributes(params[:git_repo])
        flash[:notice] = 'GitRepo was successfully updated.'
        format.html { redirect_to(@git_repo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @git_repo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /git_repos/1
  # DELETE /git_repos/1.xml
  def destroy
    @git_repo = GitRepo.find(params[:id])
    @git_repo.destroy

    respond_to do |format|
      format.html { redirect_to(git_repos_url) }
      format.xml  { head :ok }
    end
  end
end
