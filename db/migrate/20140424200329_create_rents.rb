class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.references :book, index: true
      t.boolean :returned, default: true
      t.references :student, index: true

      t.timestamps
    end
    add_foreign_key :rents, :books
    add_foreign_key :rents, :students
  end
end