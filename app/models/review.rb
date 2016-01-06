class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :ticket

    validates :review, presence: true
end
