class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.references :company, index: true
      t.timestamps
    end
    add_foreign_key :teachers, :companies
  end
end
