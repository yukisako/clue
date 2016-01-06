class CreateReportedAccounts < ActiveRecord::Migration
  def change
    create_table :reported_accounts do |t|
      t.integer :user_id
      t.integer :reporter_id
      t.text :reason

      t.timestamps null: false
    end
  end
end
