class AddReportsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reported, :integer
  end
end
