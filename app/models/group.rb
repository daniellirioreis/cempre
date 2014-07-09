class Group < ActiveRecord::Base
  belongs_to :student
  belongs_to :classroom
  has_many :faults, :dependent => :restrict_with_error
  has_many :exams, :dependent => :restrict_with_error
  has_one :questionnaire
  delegate :course, :company, to: :classroom

  delegate :day_of_birth, :name, :birth_date, to: :student

  has_enumeration_for :status, :with => StatusGroup, :create_helpers => true, :create_scopes => true

  validates :student_id, :status, presence: true

  validate :validate_group


  scope :active, -> {where("status = ?", StatusGroup::ACTIVE)}

  scope :re_enrollment, -> {where("re_enrollment = ?", true)}

  scope :second_change_exam, -> {where("second_change_exam = ?", true)}

  scope :approved, -> {where("status = ?", StatusGroup::APPROVED)}

  scope :locked_or_folded, -> {where("status = ? OR status = ?", StatusGroup::LOCKED, StatusGroup::FOLDED)}


  scope :active_or_approved_or_failed, -> {where("status = ? OR status = ? OR status = ?", StatusGroup::ACTIVE, StatusGroup::APPROVED, StatusGroup::FAILED )}


  scope :failed, -> {where("status = ?", StatusGroup::FAILED)}

  scope :no_transfer, -> {where("status != ?", StatusGroup::TRANSFER)}

  scope :sorted, -> { order("groups.status, students.name").joins(:student) }


  scope :bithday, lambda { |month| where(" EXTRACT(MONTH FROM birth_date) = #{month}").joins(:student) }

  scope :bithday_day_and_month, lambda { |day, month| where(" EXTRACT(DAY FROM birth_date) = #{day} AND EXTRACT(MONTH FROM birth_date) = #{month}").joins(:student)}


  scope :classroom_id, lambda { |id| where("classroom_id = ?", id) }

  scope :type_course, lambda { |type| where("courses.type_course = ?", type).joins(:classroom => :course) }

  scope :student_id, lambda { |id| where("student_id = ?", id) }

  scope :calendar_id, lambda { |id| where("classrooms.calendar_id = ?", id).joins(:classroom) }

  scope :down_average, lambda { |down_average| where("exams.value <=?", down_average).joins(:exams) }

  scope :type_exam, lambda { |type_exam| where("exams.type_exam = ?", type_exam) }

  scope :open_for_enrollments, -> {where("classrooms.open_for_enrollments = true ").joins(:classroom)}

  scope :open_for_enrollments_english, -> {where("classrooms.open_for_enrollments = true AND courses.type_exam #{TypeExam::ENGLISH}").joins(:classroom => :course)}



  after_save :create_transfer

  def to_s
    student
  end

  def value_tatal
    (exams.sum(:value) / exams.count).round(2)
  end

  def frequency
    total_lessons = classroom.lessons.count
    total_faults =  faults.count
    m = total_faults * 100
    mm = m / total_lessons
    100 - mm
  end

  private

  def validate_group

    if (classroom.groups.active.count + 1) > classroom.capacity
      errors.add(:student_id, "não pode ser enturmamado, turma não possui mais vaga")
    else
      if self.new_record?
        group = Group.student_id(student_id).active.type_course(classroom.course.type_course)
         if group.any?
           errors.add(:student_id, "já possui outra enturmação ativa na turma #{group.last.classroom}")
         end
      end

      unless self.new_record?
        if status == StatusGroup::LOCKED || status == StatusGroup::FOLDED
          if justification.blank?
            errors.add(:justification, :blank )
          end
        end
      end
    end
  end

  def create_transfer
      if transfer?
        group = Group.new(:student_id => student_id, :classroom_id => new_classroom_id, :status => 0)
        group.save!
      end
  end
end
