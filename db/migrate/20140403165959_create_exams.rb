class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :lesson, index: true
      t.references :group, index: true
      t.string :name
      t.float :value
      t.integer :type_exam
      t.timestamps
    end
    add_foreign_key :exams, :lessons
    add_foreign_key :exams, :groups

  end
end
