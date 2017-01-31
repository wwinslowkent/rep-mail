class Representative < ApplicationRecord
  validates :name, presence: true
  validates :state, presence: true
  validates :party, presence: true
  validates :address, presence: true
  has_many :rzips
  has_many :zipcodes, through: :rzips
end
