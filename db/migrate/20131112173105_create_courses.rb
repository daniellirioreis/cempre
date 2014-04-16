class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :company, index: true
      t.string :name

      t.timestamps
    end
    add_foreign_key :courses, :companies
  end
end
