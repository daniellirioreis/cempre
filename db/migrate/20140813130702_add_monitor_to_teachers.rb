class AddMonitorToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :monitor, :boolean, default: false
  end
end
