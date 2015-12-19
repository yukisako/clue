class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :name_kana, :string
    add_column :users, :family_name, :string
    add_column :users, :first_name, :string
    add_column :users, :family_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :user_type, :integer
    add_column :users, :area, :string
    add_column :users, :sex, :string
    add_column :users, :birth, :date
    add_column :users, :profile, :text
  end
end
