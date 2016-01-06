class AbsenceTrigger < ActiveRecord::Base
  belongs_to :user
  has_one :ticket, through: :user
end
