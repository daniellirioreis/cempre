class CreateFaults < ActiveRecord::Migration
  def change
    create_table :faults do |t|
      t.references :group, index: true
      t.references :lesson, index: true
      t.integer :justification, default: 0

      t.timestamps
    end
    add_foreign_key :faults, :groups
    add_foreign_key :faults, :lessons
  end
end
