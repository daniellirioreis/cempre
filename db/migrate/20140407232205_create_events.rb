class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :calendar_day, index: true
      t.text :description
      t.integer :type_event

      t.timestamps
    end
    add_foreign_key :events, :calendar_days
  end
end
