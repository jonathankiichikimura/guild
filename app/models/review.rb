class Review < ApplicationRecord
  belongs_to :quest
  belongs_to :giver
  belongs_to :accepter

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
