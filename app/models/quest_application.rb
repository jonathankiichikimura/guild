class QuestApplication < ApplicationRecord
  belongs_to :quest
  belongs_to :accepter

  STATUSES = %w[pending accepted rejected withdrawn].freeze

  validates :status, inclusion: { in: STATUSES }
end
