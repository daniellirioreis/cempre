class AddSequenceToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :sequence, :integer, default: 0
  end
end
