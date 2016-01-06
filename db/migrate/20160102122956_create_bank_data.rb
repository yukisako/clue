class CreateBankData < ActiveRecord::Migration
  def change
    create_table :bank_data do |t|
      t.string :bank_id
      t.integer :store_id
      t.string :bank_name
      t.string :bank_name_kana
      t.string :store_name
      t.string :store_name_kana

      t.timestamps null: false
    end
  end
end
