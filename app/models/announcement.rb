class Announcement < ApplicationRecord
  enum :target, {
    everyone: 0,
    parent: 1,
    student: 2
  }

  validates :title, :body, presence: true
end
