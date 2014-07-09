class AddCurrentCalendarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_calendar_id, :integer
  end
end
