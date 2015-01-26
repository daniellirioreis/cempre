class AddStartClassToStudents < ActiveRecord::Migration
  def change
    add_column :students, :start_class, :boolean, default: false
  end
end
