class CreateParentStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :parent_students do |t|
      t.references :parent, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
