class Accepter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quest_applications, dependent: :destroy
  has_many :quests, through: :quest_applications
  has_many :reviews, foreign_key: :accepter_id, dependent: :destroy

  def display_name
    full_name.presence || email.split("@").first
  end
end
