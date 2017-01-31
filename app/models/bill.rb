class Bill < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  has_many :bmessages
  has_many :messages, through: :bmessages
end
