class Bmessage < ApplicationRecord
    belongs_to :bill
    belongs_to :message
    # validates :bill_id, presence: true
    # validates :message_id, presence: true
end
