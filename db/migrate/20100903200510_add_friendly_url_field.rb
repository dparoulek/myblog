class AddFriendlyUrlField < ActiveRecord::Migration
  def self.up
    add_column :nodes, :friendly_url, :string
  end

  def self.down
    remove_column :nodes, :friendly_url
  end
end
