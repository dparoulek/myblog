class CreateGitRepos < ActiveRecord::Migration
  def self.up
    create_table :git_repos do |t|
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :git_repos
  end
end
