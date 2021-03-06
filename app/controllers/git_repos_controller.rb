class GitReposController < ApplicationController
  include Grit

  def list
    repo = find_repo(params)
    unless(repo) 
      render :action => 'not_found'
      return
    end 

    abspath = get_abspath(params)
    if(repo.is_a_file?(abspath))
      path = abspath
      contents = repo.getFileContents(path)
      name = repo.getFileName(path)
      logger.debug("Displaying file named #{name} inside the #{path} directory inside the '#{repo.name}' git repo")
      @node = Node.find(:first, :conditions => {:git_repo_id => repo.id, :git_repo_path => path})
      unless @node
        @node = Node.new(:name => name, :git_repo_id => repo.id, :git_repo_path => path)
      end
      render :action => "file"          
    else # This is a directory
      @git_repo_name = repo.name
      tree = repo.getDirectory(abspath)
      @files = tree.blobs
      @dirs = tree.trees
      @path = abspath
      logger.debug("Listing files inside the #{@path} directory inside the '#{repo.name}' git repo")
      render :action => "list"
    end
  end

  def publish
    respond_to do |format|
      format.js
    end
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

  # Edit a file controlled by git
  def edit_file
    @node = Node.new(:name => params[:name], :git_repo_id => params[:git_repo_id], :git_repo_path => params[:git_repo_path])
  end

  # TODO: Probably need to add logic for what type sof things can be
  # saved to file. Like make sure there's no source code outside of
  # <code> tags, for example
  #
  # TODO: what should really happen here is it should create a branch,
  # then change the file, then commit, and then merge so that 2 people
  # can edit same file thru the web at the same time
  def save_file 
    Grit.debug = true
    contents = params[:contents]
    message = params[:commit_message]
    @node = Node.new(:name => params[:name], :git_repo_id => params[:git_repo_id], :git_repo_path => params[:git_repo_path])
    save_file_to_disk(contents, @node.abspath)
    stage_and_commit_file(@node.repo_base_path, @node.git_repo_path, message)
    flash[:notice] = "Created New Version"
    render :action => :file
  end

  # Save a file controlled by git
  def save_file_to_disk(new_content, filepath) 
    File.open(filepath, 'w') { |f| f.write(new_content)}
  end

  # stage and commit changes 
  def stage_and_commit_file(repo_base_path, relpath_to_file, commit_message = nil)
    commit_message = "Updated #{relpath_to_file} via website" unless !commit_message.blank?
    gitRepo = Repo.new(repo_base_path)
    olddir = Dir.pwd
    Dir.chdir(repo_base_path)
    gitRepo.add(relpath_to_file)
    gitRepo.commit_index(commit_message)
    Dir.chdir(olddir)
  end

  # POST /git_repos
  # POST /git_repos.xml
  def create
    @git_repo = GitRepo.new(params[:git_repo])
    
    respond_to do |format|
      if @git_repo.save
        flash[:notice] = 'GitRepo was successfully created.'
        if reindex(@git_repo.path, {:id => @git_repo.id, :git_repo_path => @git_repo.path, :git_repo_name => @git_repo.name})
          flash[:notice] += ' Search Index was updated successfully'
        end
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

  private
  def find_repo(params)
    repo = nil
    if(params[:name])
      logger.debug("Attemping to find git repo by name '#{params[:name]}'")
      repo = GitRepo.find_by_name(params[:name])
      if repo then logger.debug("Found git repo by name '#{repo.name}'") end
    end

    if(params[:id])
      logger.debug("Attemping to find git repo by ID '#{params[:id]}'")
      repo = GitRepo.find(params[:id])
      if repo then logger.debug("Found git repo by ID '#{repo.id}'") end
    end
    
    repo
  end

  def get_abspath(params)
    # :path is present because we have a tricky catch-all route set
    # up. See the last entry in routes.rb. :path will be an array of
    # subdirs. The last entry in the :path array might be a file
    # name. '/' is actually a method on Grit:Rep that takes a path as a
    # parameter.
    abspath = params[:path] && !params[:path].empty? ? params[:path] * '/' : '/'
  end
end
