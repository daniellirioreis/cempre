class AddFieldMonitoringInEvents < ActiveRecord::Migration
  def change
    add_column :events, :teacher_id, :integer
    add_column :events, :student_id, :integer
    add_foreign_key :events, :teachers
    add_foreign_key :events, :students
  end
end
