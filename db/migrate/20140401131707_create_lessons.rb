class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :classroom, index: true
      t.references :calendar_day, index: true

      t.timestamps
    end
    add_foreign_key :lessons, :classrooms
    add_foreign_key :lessons, :calendar_days
  end
end
