class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :calendar, index: true
      t.references :course, index: true
      t.integer :day_week

      t.timestamps
    end
    add_foreign_key :plans, :calendars
    add_foreign_key :plans, :courses
  end
end
