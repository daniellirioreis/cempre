class AddLimitOfFaultsToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :limit_of_faults, :integer, default: 0
  end
end
