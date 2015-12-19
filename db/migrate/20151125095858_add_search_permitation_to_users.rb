class AddSearchPermitationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search_permit, :integer
  end
end
