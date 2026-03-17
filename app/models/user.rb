class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { quest_giver: 0, quest_accepter: 1 }

  has_many :quests_given, class_name: "Quest", foreign_key: :quest_giver_id, dependent: :destroy
  has_many :quests_accepted, class_name: "Quest", foreign_key: :quest_accepter_id
  has_many :reviews_given, class_name: "Review", foreign_key: :reviewer_id
  has_many :reviews_received, class_name: "Review", foreign_key: :reviewee_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
end
