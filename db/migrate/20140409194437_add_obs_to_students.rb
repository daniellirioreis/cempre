class AddObsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :obs, :text
  end
end
