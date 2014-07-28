class AddBuyTheBookToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :buy_the_book, :boolean
  end
end
