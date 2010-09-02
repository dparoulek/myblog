class SearchController < ApplicationController
  def index 
    if(params[:search])
      @phrase = params[:search]
      logger.debug("Searching for '#{@phrase}' in '#{search_index_dir}")
      @search_results = search_index(@phrase, [:file_name, :git_repo_path, :git_repo_name, :abs_file_path])
    end
  end
end
