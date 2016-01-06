class AddUserIdsToAbsenceTriggers < ActiveRecord::Migration
  def change
    add_column :absence_triggers, :user_id, :integer
  end
end
