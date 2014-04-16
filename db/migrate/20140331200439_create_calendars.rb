class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.references :company, index: true
      t.date :date_start
      t.date :date_end
      t.string :name
      t.timestamps
    end
    add_foreign_key :calendars, :companies
  end
end
