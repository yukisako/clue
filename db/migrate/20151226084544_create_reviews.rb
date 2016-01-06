class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :ticket_id
      t.integer :user_id
      t.text :review

      t.timestamps null: false
    end
  end
end
