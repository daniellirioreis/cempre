class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :company, index: true
      t.string :title
      t.string :code
      t.text :description
      t.integer :level
      t.integer :language

      t.timestamps
    end
    add_foreign_key :books, :companies
  end
end
