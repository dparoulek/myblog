class UpdateNode2 < ActiveRecord::Migration
  def self.up
    add_column :nodes, :public, :boolean
    add_column :nodes, :publish_date, :datetime
  end

  def self.down
    remove_column :nodes, :public
    remove_column :nodes, :publish_date
  end
end
