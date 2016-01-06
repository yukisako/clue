class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :ticket_id
      t.integer :user_id
      t.integer :price
      t.decimal :length
      t.datetime :meet_at
      t.string :area
      t.string :place
      t.text :message
      t.integer :status

      t.timestamps null: false
    end
  end
end
