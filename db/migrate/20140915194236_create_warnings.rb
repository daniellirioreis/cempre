class CreateWarnings < ActiveRecord::Migration
  def change
    create_table :warnings do |t|
      t.references :student, index: true
      t.references :calendar_day, index: true
      
      t.text :description

      t.timestamps
    end
    add_foreign_key :warnings, :students    
    add_foreign_key :warnings, :calendar_days            
  end
end
