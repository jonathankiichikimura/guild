class Quest < ApplicationRecord
  belongs_to :quest_giver, class_name: "User"
  belongs_to :quest_accepter, class_name: "User", optional: true
  has_many :reviews

  STATUSES = %w[open in_progress completed].freeze
  CATEGORIES = %w[groceries gardening tech_help transport household other].freeze

  validates :title, presence: true
  validates :description, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
end
