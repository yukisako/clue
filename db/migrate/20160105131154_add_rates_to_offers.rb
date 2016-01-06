class AddRatesToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :rate, :integer
  end
end
