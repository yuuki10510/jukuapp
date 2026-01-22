class Announcement < ApplicationRecord
  validates :title, :body, presence: true
end
