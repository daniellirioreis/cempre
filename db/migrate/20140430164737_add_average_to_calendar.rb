class AddAverageToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :average, :float, default: 0
  end
end
