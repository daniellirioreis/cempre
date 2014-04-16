class AddTypeCourseToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :type_course, :integer, default: 0
  end
end
