class GitController < ApplicationController
  include Grit

  def ls
    repo = GitRepo.find(params[:id])
    grit = Repo.new(repo.path)
    root = grit.tree
    @listing = root.contents.collect do |entry| entry.name  end
  end
end
