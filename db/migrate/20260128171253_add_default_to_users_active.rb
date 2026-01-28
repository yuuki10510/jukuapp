class AddDefaultToUsersActive < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :active, true
  end
end
