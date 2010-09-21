class AddCommentFields < ActiveRecord::Migration
  def self.up
    add_column :comments, :email, :string
    add_column :comments, :homepage, :string
    add_column :comments, :subject, :string
    add_column :comments, :hostname, :string
  end

  def self.down
    remove_column :comments, :email
    remove_column :comments, :homepage
    remove_column :comments, :subject
    remove_column :comments, :hostname
  end
end
