class AddFatherToStudents < ActiveRecord::Migration
  def change
    add_column :students, :father, :string
  end
end
