class QuestAcceptance < ApplicationRecord
  belongs_to :quest
  belongs_to :user

  STATUSES = %w[active withdrawn completed].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :user_id, uniqueness: { scope: :quest_id }
end
