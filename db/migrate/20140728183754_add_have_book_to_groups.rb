class AddHaveBookToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :have_book, :boolean, default: false
  end
end
