class AddLinkPhotoToStudents < ActiveRecord::Migration
  def change
    add_column :students, :link_photo, :text
  end
end
