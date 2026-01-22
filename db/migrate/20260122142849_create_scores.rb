class CreateScores < ActiveRecord::Migration[8.1]
  def change
    create_table :scores do |t|
      t.references :student, null: false, foreign_key: true
      t.string :subject
      t.integer :score
      t.string :test_type
      t.string :term

      t.timestamps
    end
  end
end
