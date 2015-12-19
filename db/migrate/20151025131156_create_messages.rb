class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :title
      t.text :message
      t.integer :sent
      t.integer :opened

      t.timestamps null: false
    end
  end
end
