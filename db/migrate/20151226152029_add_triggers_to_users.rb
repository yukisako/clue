class AddTriggersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :classroom, :boolean
    add_column :users, :harm, :boolean
    add_column :users, :antipathy, :boolean
    add_column :users, :teacher, :boolean
    add_column :users, :friendship, :boolean
    add_column :users, :study, :boolean
    add_column :users, :change_school, :boolean
    add_column :users, :neglect, :boolean
    add_column :users, :dv, :boolean
    add_column :users, :poverty, :boolean
    add_column :users, :parents, :boolean
    add_column :users, :no_reason, :boolean
  end
end
