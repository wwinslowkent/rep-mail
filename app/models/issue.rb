class Issue < ApplicationRecord
  validates :title, presence: true
  has_many :issues_messages
  has_many :messages, through: :issues_messages
end
