class StudentProfile < ApplicationRecord
  belongs_to :user

  enum :grade, {
    小1: 1,
    小2: 2,
    小3: 3,
    小4: 4,
    小5: 5,
    小6: 6,
    中1: 7,
    中2: 8,
    中3: 9,
    高1: 10,
    高2: 11,
    高3: 12
  }

  validates :school_name, :grade, presence: true
end
