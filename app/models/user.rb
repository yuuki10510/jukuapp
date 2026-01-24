class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, parent: 1, student: 2 }

  validates :name, presence: true
  validates :role, presence: true

  has_one :student_profile, dependent: :destroy
  has_many :parent_students, foreign_key: :parent_id
  has_many :children, through: :parent_students, source: :student

  has_many :scores, foreign_key: :student_id
end
