class CreateCalendarDays < ActiveRecord::Migration
  def change
    create_table :calendar_days do |t|
      t.references :calendar, index: true
      t.date :day

      t.timestamps
    end
    add_foreign_key :calendar_days, :calendars
  end
end
