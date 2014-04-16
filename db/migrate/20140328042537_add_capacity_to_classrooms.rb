class AddCapacityToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :capacity, :integer, :default => 0
  end
end
