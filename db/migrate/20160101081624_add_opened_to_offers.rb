class AddOpenedToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :updated, :integer
  end
end
