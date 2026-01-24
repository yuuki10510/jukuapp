class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def up
    change_table :users do |t|
      t.string :encrypted_password, default: "", null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end

    add_index :users, :reset_password_token, unique: true
  end

  def down
    remove_index :users, :reset_password_token
    change_table :users do |t|
      t.remove :encrypted_password, :reset_password_token,
               :reset_password_sent_at, :remember_created_at
    end
  end
end
