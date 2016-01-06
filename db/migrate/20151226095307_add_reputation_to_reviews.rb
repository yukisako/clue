class AddReputationToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :reputation, :integer
  end
end
