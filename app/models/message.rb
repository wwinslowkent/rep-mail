class Message < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  has_many :bmessages
  has_many :bills, through: :bmessages
  has_many :issues_messages
  has_many :issues, through: :issues_messages
end
