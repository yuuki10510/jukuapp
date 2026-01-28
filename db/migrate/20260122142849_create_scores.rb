class CreateScores < ActiveRecord::Migration[8.1]
  def change
    create_table :scores do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.integer :subject, null: false
      t.integer :score, null: false
      t.integer :test_type, null: false
      t.integer :term, null: false

      t.timestamps
    end
  end
end
