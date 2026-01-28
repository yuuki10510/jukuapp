class CreateWithdrawals < ActiveRecord::Migration[8.1]
  def change
    create_table :withdrawals do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.text :reason, null: false

      t.timestamps
    end
  end
end
