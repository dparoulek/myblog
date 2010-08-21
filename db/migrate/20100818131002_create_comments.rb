class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :username
      t.text :comment
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
