class Exam < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :group
  
  delegate :classroom, to: :group 
    
  
  has_enumeration_for :type_exam, :create_helpers => true, :create_scopes => true

  validates :group_id, :type_exam, :value, presence: true

  validate :validate_lesson_id
  
  

  validates :type_exam, uniqueness: { scope: :group_id }

  scope :student_id, lambda { |id| where("groups.student_id = ?", id).joins(:group) }
  
  def calendar
    classroom.calendar
  end
  
  private 
  
  def validate_lesson_id
    errors.add(:lesson_id, "não foi gerada/dia da prova não foi definido")  if lesson.nil?
  end
end
