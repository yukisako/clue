class Offer < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  has_many :messages

  accepts_nested_attributes_for :messages

  def self.payed
    where('meet_at <= ?', Time.now)
  end
end
