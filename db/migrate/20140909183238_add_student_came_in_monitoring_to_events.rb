class AddStudentCameInMonitoringToEvents < ActiveRecord::Migration
  def change
    add_column :events, :student_came_in_monitoring, :boolean, default: true
  end
end
