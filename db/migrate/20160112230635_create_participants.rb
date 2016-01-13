class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end
  end
end
