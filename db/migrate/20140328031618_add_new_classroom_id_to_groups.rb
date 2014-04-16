class AddNewClassroomIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :new_classroom_id, :integer
  end
end
