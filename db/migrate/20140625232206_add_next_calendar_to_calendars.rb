class AddNextCalendarToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :next_calendar_id, :integer
    add_foreign_key :calendars, :calendars, name: :index_next_calendar, column: :next_calendar_id
  end
end
