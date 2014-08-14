class CreateScheduleTeachers < ActiveRecord::Migration
  def change
    create_table :schedule_teachers do |t|
      t.time :time_start
      t.time :time_end
      t.integer :day_week
      t.belongs_to :teacher, index: true

      t.timestamps
    end
  end
end
