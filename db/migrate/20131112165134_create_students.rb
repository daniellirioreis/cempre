class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :company, index: true
      t.string :name

      t.timestamps
    end
    add_foreign_key :students, :companies
  end
end
