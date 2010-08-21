class AddCommentsToNodes < ActiveRecord::Migration
  def self.up
    add_column :comments, :node_id, :integer
  end

  def self.down
    remove_column :comments, :node_id
  end
end
