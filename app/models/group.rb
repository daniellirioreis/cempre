class Group < ActiveRecord::Base
  belongs_to :student
  belongs_to :classroom
  has_many :faults
  has_many :exams
  has_enumeration_for :status, :with => StatusGroup, :create_helpers => true, :create_scopes => true

  validates :student_id, :status, presence: true
  validate :validate_group

  scope :active, -> {where("status = ?", StatusGroup::ACTIVE)}
  scope :approved, -> {where("status = ?", StatusGroup::APPROVED)}
  scope :failed, -> {where("status = ?", StatusGroup::FAILED)}
  scope :no_transfer, -> {where("status != ?", StatusGroup::TRANSFER)}

  scope :classroom_id, lambda { |id| where("classroom_id = ?", id) }
  scope :type_course, lambda { |type| where("courses.type_course = ?", type).joins(:classroom => :course) }

  scope :student_id, lambda { |id| where("student_id = ?", id) }

  scope :calendar_id, lambda { |id| where("classrooms.calendar_id = ?", id).joins(:classroom) }

  after_save :create_transfer

  def to_s
    student
  end

  def value_tatal
    exams.sum(:value)
  end

  private

  def validate_group
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
  def create_transfer
      if transfer?
        group = Group.new(:student_id => student_id, :classroom_id => new_classroom_id, :status => 0)
        group.save!
      end
  end
end
