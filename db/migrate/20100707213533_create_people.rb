class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.email :email
      t.password :password

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
