class AddClosedToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :closed, :boolean, default: false
  end
end
