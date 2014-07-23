class AddLevelCourseToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :level_course, :integer, default: 0
  end
end
