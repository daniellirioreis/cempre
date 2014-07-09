class AddBlockScheduleDifferentToStudents < ActiveRecord::Migration
  def change
    add_column :students, :block_schedule_different, :boolean, default: false
  end
end
