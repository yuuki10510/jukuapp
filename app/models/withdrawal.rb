class Withdrawal < ApplicationRecord
  belongs_to :student, class_name: "User"

  validates :reason, presence: true
end
