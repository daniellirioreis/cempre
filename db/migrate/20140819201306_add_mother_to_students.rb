class AddMotherToStudents < ActiveRecord::Migration
  def change
    add_column :students, :mother, :string
  end
end
