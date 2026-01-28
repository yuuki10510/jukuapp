class AddTargetToAnnouncements < ActiveRecord::Migration[8.1]
  def change
    add_column :announcements, :target, :integer, default: 0, null: false
  end
end
