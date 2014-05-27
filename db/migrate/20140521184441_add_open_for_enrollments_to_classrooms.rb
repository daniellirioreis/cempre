class AddOpenForEnrollmentsToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :open_for_enrollments, :boolean, default: false
  end
end
