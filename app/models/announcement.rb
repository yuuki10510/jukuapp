class Announcement < ApplicationRecord
  enum :target, {
    everyone: 0,
    parent: 1,
    student: 2
  }

  validates :title, :body, presence: true

  #利用者向け表示スコープ
  scope :visible_to, ->(user) {
    if user.parent?
      where(target: [:everyone, :parent])
    elsif user.student?
      where(target: [:everyone, :student])
    else
      none
    end
  }
end
