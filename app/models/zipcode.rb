class Zipcode < ApplicationRecord
  validates :zip, presence: true, numericality: true, length: { is: 5 , message: "must be 5 digits"}
  has_many :rzips
  has_many :representatives, through: :rzips
end
