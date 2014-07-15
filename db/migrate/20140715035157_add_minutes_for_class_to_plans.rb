class AddMinutesForClassToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :minutes_for_class, :integer, default: 0
  end
end
