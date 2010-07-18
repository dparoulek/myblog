class PersonAddCols < ActiveRecord::Migration
  def self.up
    add_column :people, :email, :string
    add_column :people, :password, :string
  end

  def self.down
    remove_column :people, :email
    remove_column :people, :password
  end
end
