class AddStudentIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :student_id, :integer

    add_foreign_key :users, :students
  end
end
