class RemoveTriggersFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :classroom, :boolean
    remove_column :users, :harm, :boolean
    remove_column :users, :antipathy, :boolean
    remove_column :users, :teacher, :boolean
    remove_column :users, :friendship, :boolean
    remove_column :users, :study, :boolean
    remove_column :users, :change_school, :boolean
    remove_column :users, :neglect, :boolean
    remove_column :users, :dv, :boolean
    remove_column :users, :poverty, :boolean
    remove_column :users, :parents, :boolean
    remove_column :users, :no_reason, :boolean
    remove_column :users, :about, :string
    remove_column :users, :price, :number
    remove_column :users, :absence_trigger, :text
  end
end
