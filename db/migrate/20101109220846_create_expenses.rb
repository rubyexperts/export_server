class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses  do |t|
      t.integer :id
      t.integer :user_id
      t.string :name
      t.decimal :exchangerate
      t.decimal :total_amount
      t.decimal :total_amount_euro
      t.decimal :total_amount_marketing
      t.decimal :total_amount_marketing_euro
      t.string :status
      t.datetime :createdate
      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
