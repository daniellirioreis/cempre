class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :student, index: true
      t.references :classroom, index: true
      t.integer :status

      t.timestamps
    end
    add_foreign_key :groups, :students
    add_foreign_key :groups, :classrooms
  end
end
