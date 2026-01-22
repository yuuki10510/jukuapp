class CreateWithdrawals < ActiveRecord::Migration[8.1]
  def change
    create_table :withdrawals do |t|
      t.references :student, null: false, foreign_key: true
      t.text :reason

      t.timestamps
    end
  end
end
