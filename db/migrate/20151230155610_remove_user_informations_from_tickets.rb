class RemoveUserInformationsFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :host_sex, :string
    remove_column :tickets, :host_birth, :date
    remove_column :tickets, :host_absent_span, :string
  end
end
