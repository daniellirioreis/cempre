class Course < ActiveRecord::Base
  belongs_to :company
  has_many :classrooms
  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }

  has_enumeration_for :type_course, :create_helpers => true, :create_scopes => true

  scope :sorted, -> { order(:name) }

  def to_s
    name
  end
end
