class CreateControlPoints < ActiveRecord::Migration
  def change
    create_table :control_points do |t|
      t.references :teacher, index: true
      t.references :calendar_day, index: true
      t.time :time_start
      t.time :time_end
      t.boolean :closed, default: false

      t.timestamps
    end
    add_foreign_key :control_points, :teachers    
    add_foreign_key :control_points, :calendar_days
  end
end
