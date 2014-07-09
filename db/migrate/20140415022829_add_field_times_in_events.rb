class AddFieldTimesInEvents < ActiveRecord::Migration
  def change
    add_column :events, :time_start, :time
    add_column :events, :time_end, :time
  end
end
