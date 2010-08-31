class ChangeGitRepoIdType < ActiveRecord::Migration
  def self.up
    remove_column :nodes, :git_repo_id
    add_column :nodes, :git_repo_id, :integer
  end

  def self.down
    remove_column :nodes, :git_repo_id
    add_column :nodes, :git_repo_id, :string
  end
end
