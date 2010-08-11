class UpdateNode < ActiveRecord::Migration
  def self.up
    add_column :nodes, :git_repo_id, :string
    add_column :nodes, :git_repo_path, :string
    add_column :nodes, :mode, :string
    add_column :nodes, :user_id, :integer
    add_column :nodes, :group_id, :integer
    remove_column :nodes, :contents
    remove_column :nodes, :path
  end

  def self.down
    remove_column :nodes, :git_repo_id
    remove_column :nodes, :git_repo_path
    remove_column :nodes, :mode
    remove_column :nodes, :user_id
    remove_column :nodes, :group_id
    add_column :nodes, :contents, :text
    add_column :nodes, :path, :string
  end
end
