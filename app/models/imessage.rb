class IssuesMessage < ApplicationRecord
  belongs_to :issue
  belongs_to :message
  # validates :issue_id, presence: true
  # validates :message_id, presence: true
end
