class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.integer :bank_id
      t.string :store_id
      t.string :name
      t.string :name_kana
      t.integer :bank_flag

      t.timestamps null: false
    end
  end
end
