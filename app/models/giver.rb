class Giver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quests, foreign_key: :giver_id, dependent: :destroy
  has_many :reviews, foreign_key: :giver_id, dependent: :destroy

  include TokyoWard

  validates :first_name, presence: true

  def display_name
    first_name.presence || email.split("@").first
  end
end
