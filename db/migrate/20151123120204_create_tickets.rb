class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :title
      t.integer :price
      t.integer :length
      t.integer :rate
      t.string :area
      t.string :place
      t.text :message

      t.timestamps null: false
    end
  end
end
