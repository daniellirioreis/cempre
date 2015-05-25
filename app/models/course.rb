class Course < ActiveRecord::Base
  belongs_to :company
  has_many :classrooms
  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }

  has_enumeration_for :type_course, :create_helpers => true, :create_scopes => true
  has_enumeration_for :level_course, :create_helpers => true, :create_scopes => true

  scope :sorted, -> { order(:type_course, :sequence) }

  scope :by_level_course, lambda { |level| where("level_course = ?", level) }

  def to_s
    name
  end

  def groups(calendar_id)
    Group.active.calendar_id(calendar_id).course_id(id)
  end
  
end
