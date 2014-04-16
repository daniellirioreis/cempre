class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :company, index: true
      t.text :subject
      t.integer :for_note
      t.references :user, index: true

      t.timestamps
    end
    add_foreign_key :notes, :users
    add_foreign_key :notes, :companies
  end
end
