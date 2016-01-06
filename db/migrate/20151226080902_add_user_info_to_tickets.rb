class AddUserInfoToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :host_sex, :string
    add_column :tickets, :host_birth, :date
    add_column :tickets, :host_absent_span, :string
  end
end
