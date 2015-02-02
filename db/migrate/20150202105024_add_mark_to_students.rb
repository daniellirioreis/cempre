class AddMarkToStudents < ActiveRecord::Migration
  def change
    add_column :students, :mark, :boolean, default: false
  end
end
