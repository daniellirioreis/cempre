class AddLinkImageToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :link_image, :text
  end
end
