class Exam < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :group
  
  delegate :classroom, to: :group 
  
  has_enumeration_for :type_exam, :create_helpers => true, :create_scopes => true

  validates :group_id, :lesson_id, :type_exam, :value, presence: true

  validates :type_exam, uniqueness: { scope: :group_id }

  scope :student_id, lambda { |id| where("groups.student_id = ?", id).joins(:group) }

end
