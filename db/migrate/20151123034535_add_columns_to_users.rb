class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :tel, :string
    add_column :users, :job, :string
    add_column :users, :line_id, :string
    add_column :users, :about, :string
    add_column :users, :price, :integer
  end
end
