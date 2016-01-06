class AddOfferIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :offer_id, :integer
  end
end
