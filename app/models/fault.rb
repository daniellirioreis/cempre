class Fault < ActiveRecord::Base
  belongs_to :group
  belongs_to :lesson
  has_enumeration_for :justification, :with => JustificationsFault, :create_helpers => true, :create_scopes => true

  validate :validate_fault


  validates :group_id, :lesson_id, :justification, presence: true

  validates :lesson_id, uniqueness: { scope: :group_id }

  scope :student_id, lambda { |id| where("groups.student_id = ?", id).joins(:group) }
  
  scope :justification, lambda { |justification| where("faults.justification = ?", justification) }
  
  
  scope :calendar_id_and_student_id, lambda { |calendar_id, student_id| where("classrooms.calendar_id = ? AND groups.student_id = ?", calendar_id, student_id).joins(:group => :classroom) }

  scope :calendar_day_id_and_student_id, lambda { |calendar_day_id, student_id| where("lessons.calendar_day_id = ? AND groups.student_id = ?", calendar_day_id, student_id).joins(:group, :lesson) }

  scope :calendar_id_and_student_id_type_course, lambda { |calendar_id, student_id, type_course| where("classrooms.calendar_id = ? AND groups.student_id = ? AND courses.type_course = ?", calendar_id, student_id, type_course).joins(:group => [:classroom => :course]) }

  scope :sorted, -> { order("calendar_days.day").joins(:lesson => :calendar_day) }

  delegate :to_string, to: :lesson
  delegate :classroom, to: :group
  delegate :calendar, to: :classroom

  def to_s
    "#{lesson.calendar_day}"
  end

  private

  def validate_fault
    if lesson.present?
      if lesson.calendar_day.day > Date.today
        errors.add(:lesson_id, "Falta não pode ser lançada para datas futuras" )
      else
        date_active = group.created_at.strftime("%Y%m%d").to_i
        date_lesson = lesson.calendar_day.day.to_s.gsub("-","").to_i
        errors.add(:lesson_id, "Falta não pode ser lançada, aluno foi transferido depois dessa data" ) if date_lesson < date_active
      end
    end
  end
end
