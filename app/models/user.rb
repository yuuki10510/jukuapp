class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  enum :role, { admin: 0, parent: 1, student: 2 }

  scope :students, -> { where(role: roles[:student]) }
  scope :parents,  -> { where(role: roles[:parent]) }
  scope :admins,   -> { where(role: roles[:admin]) }
  
  # === バリデーション ===
  validates :name, presence: true
  validates :email, presence: true, unless: :student?
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            unless: :student?,
            allow_blank: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :password, presence: true, on: :create

  # === 生徒プロフィール ===
  has_one :student_profile, dependent: :destroy

  # === 保護者 → 生徒 ===
  has_many :parent_students,
           foreign_key: :parent_id,
           dependent: :destroy

  has_many :children,
           through: :parent_students,
           source: :student

  # === 生徒 → 保護者 ===
  has_many :reverse_parent_students,
           class_name: "ParentStudent",
           foreign_key: :student_id,
           dependent: :destroy

  has_many :parents,
           through: :reverse_parent_students,
           source: :parent

  # === 成績（生徒のみ）===
  has_many :scores,
           foreign_key: :student_id,
           dependent: :destroy

  # === Devise: 有効／無効制御 ===
  def active_for_authentication?
    super && active?
  end

  def inactive_message
    "無効なアカウントです"
  end
end
