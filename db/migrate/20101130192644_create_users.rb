class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.string :display_name
      t.string :email
      t.integer :user_level
      t.string :salt
      t.string :site
      t.string :direct_indirect, :limit => 1
      t.string :reports_to
      t.string :cost_center
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
