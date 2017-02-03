class Vote < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :vote, presence: true
  belongs_to :user
  belongs_to :message

end
