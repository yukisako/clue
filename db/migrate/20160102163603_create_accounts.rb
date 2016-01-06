class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :bank_id
      t.integer :store_id
      t.string :bank_name
      t.string :store_name
      t.string :account_id
      t.string :user_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
