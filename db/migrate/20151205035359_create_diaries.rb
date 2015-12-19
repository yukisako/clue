class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :category
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :permit

      t.timestamps null: false
    end
  end
end
