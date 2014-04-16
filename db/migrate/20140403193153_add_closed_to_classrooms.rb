class AddClosedToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :closed, :boolean, default: false
  end
end
