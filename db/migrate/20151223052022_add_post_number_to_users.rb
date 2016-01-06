class AddPostNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :post_number, :string
    add_column :users, :permit_info_mail, :integer
    add_column :users, :absent_span, :string
    add_column :users, :absence_trigger, :text
    add_column :users, :school, :text
    add_column :users, :grade, :text
  end
end
