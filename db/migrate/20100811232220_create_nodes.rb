class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string :name
      t.string :git_repo_id
      t.string :git_repo_path
      t.boolean :public
      t.datetime :publish_date

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
