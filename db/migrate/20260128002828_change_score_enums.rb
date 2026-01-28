class ChangeScoreEnums < ActiveRecord::Migration[8.1]
  def change
    change_column :scores, :subject, :integer, using: 'subject::integer'
    change_column :scores, :test_type, :integer, using: 'test_type::integer'
    change_column :scores, :term, :integer, using: 'term::integer'
  end
end
