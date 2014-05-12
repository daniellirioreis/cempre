class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :plan, index: true
      t.references :calendar_day, index: true

      t.timestamps
    end
    add_foreign_key :schedules, :plans
    add_foreign_key :schedules, :calendar_days
  end
end
