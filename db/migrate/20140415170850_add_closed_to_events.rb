class AddClosedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :closed, :boolean, default: false
  end
end
