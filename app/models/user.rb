class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quests
  has_many :quest_acceptances
  has_many :accepted_quests, through: :quest_acceptances, source: :quest
  has_many :reviews_given, class_name: "Review", foreign_key: :reviewer_id
  has_many :reviews_received, class_name: "Review", foreign_key: :reviewee_id

  validates :first_name, presence: true
  validates :last_name, presence: true
end
