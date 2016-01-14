class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.datetime :held_at
      t.string :price

      t.timestamps null: false
    end
  end
end
