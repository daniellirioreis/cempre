class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.references :course, index: true
      t.references :company, index: true
      t.integer :day_week
      t.time :time_start
      t.time :time_end
      t.references :teacher, index: true

      t.timestamps
    end
    add_foreign_key :classrooms, :companies
    add_foreign_key :classrooms, :teachers
    add_foreign_key :classrooms, :courses
  end
end
