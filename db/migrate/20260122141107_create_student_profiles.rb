class CreateStudentProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :student_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :school_name
      t.integer :grade
      t.boolean :active

      t.timestamps
    end
  end
end
