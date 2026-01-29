class AddUniqueIndexToScores < ActiveRecord::Migration[8.1]
  def change
    add_index :scores,
      [:student_id, :subject, :term, :test_type],
      unique: true,
      name: "index_scores_unique_per_test"
  end
end
