class AddReEnrollmentToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :re_enrollment, :boolean, default: true
  end
end
