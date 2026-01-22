class StudentProfile < ApplicationRecord
  belongs_to :user

  validates :school_name, :grade, presence: true
end
