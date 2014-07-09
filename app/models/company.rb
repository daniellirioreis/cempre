class Company < ActiveRecord::Base
  has_many :students
  has_many :courses
  has_many :teachers
  has_many :classrooms
  has_many :calendars
  has_many :notes
  has_many :books
  has_many :questions
  has_many :answers
  has_many :enrollments
  # validates :name, :street, :neighborhood, :city, :federal_unit, :house_number, presence: true
  # validates :name, :email, uniqueness: true
  #
  # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  scope :sorted, -> { order(:name) }
  
  scope :open, -> {where(closed: false )}
  

  def to_s
    name
  end

  def vacancies_to_be_filled
    vacancy - students.count
  end
end
