class AddBookToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :book , :string
  end
end
