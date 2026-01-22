class Score < ApplicationRecord
  belongs_to :student, class_name: "User"

  validates :subject, :score, :test_type, :term, presence: true
end
