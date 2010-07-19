class UpdateGitrepo < ActiveRecord::Migration
  def self.up
    add_column :git_repos, :name, :string
  end

  def self.down
    remove_column :git_repos, :name
  end
end
