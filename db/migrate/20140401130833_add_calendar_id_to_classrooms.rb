class AddCalendarIdToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :calendar_id, :integer
    add_foreign_key :classrooms, :calendars
  end
end
