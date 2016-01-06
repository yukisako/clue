class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :amount
      t.string :bank_name
      t.string :store_name
      t.string :account_id
      t.string :user_name

      t.timestamps null: false
    end
  end
end
