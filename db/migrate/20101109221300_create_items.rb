class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :expense_id
      t.integer :account_id
      t.integer :project_id
      t.string  :cost_center
      t.integer :user_id
      t.datetime :expense_date
      t.string :item_description
      t.decimal :linecost
      t.boolean :ptslmarketing
      t.decimal :linecost_euro
      t.decimal :exchangerate
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
