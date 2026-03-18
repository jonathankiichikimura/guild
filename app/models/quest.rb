class Quest < ApplicationRecord
  belongs_to :giver
  belongs_to :accepter, optional: true
  has_many :reviews, dependent: :destroy
  has_many :quest_applications, dependent: :destroy

  STATUSES = %w[open in_progress completed].freeze
  CATEGORIES = %w[groceries gardening tech_help transport household other].freeze

  validates :title, presence: true
  validates :description, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
end
