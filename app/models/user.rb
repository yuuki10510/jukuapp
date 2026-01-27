class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  enum :role, { admin: 0, parent: 1, student: 2 }

  validates :name, presence: true
  validates :email, presence: true, unless: :student?
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: :student?, allow_blank: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :password, presence: true, on: :create

  has_one :student_profile, dependent: :destroy
  has_many :parent_students, foreign_key: :parent_id
  has_many :children, through: :parent_students, source: :student

  has_many :scores, foreign_key: :student_id

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    "無効なアカウントです"
  end
end
