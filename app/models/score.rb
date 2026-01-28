class Score < ApplicationRecord
  belongs_to :student, class_name: "User"

  enum subject: {
    math: 0,
    english: 1,
    japanese: 2,
    science: 3,
    social: 4
  }

  enum test_type: {
    regular: 0,
    mock: 1
  }

  enum term: {
    first_mid: 0,
    first_end: 1,
    second_mid: 2,
    second_end: 3,
    third_mid: 4,
    year_end: 5
  }

  validates :subject, :score, :test_type, :term, presence: true
end
