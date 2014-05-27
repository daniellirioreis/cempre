class Student < ActiveRecord::Base
  belongs_to :company
  has_one :user, :dependent => :destroy
  has_many :groups, :dependent => :restrict_with_error
  has_many :events
  has_many :rents

  validates :company_id, :name, :street, :neighborhood, :city, :federal_unit, :house_number, presence: true
  validates :name, :email, uniqueness: true
  validates :email, uniqueness: { scope: :company_id }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  after_save :create_user

  scope :sorted, -> { order(:name) }


  def to_s
    name
  end

  def day_of_birth
    if birth_date.present?
      birth_date.day
    end
  end

  def borrowed_books
    rents.not_returned
  end

  def age
    if birth_date.present?
      Date.today.year - birth_date.year
    end
  end

  def default_email
    "#{name.gsub(' ', '').downcase}@cempre.com"
  end

  def faults
    Fault.student_id(id)
  end

  def exams
    Exam.student_id(id)
  end

  private


  def create_user
    if user = User.find_by_student_id(id)
      user.update_attributes(name: name, email: email, password: 12345678, password_confirmation: 12345678, student_id: id, profile_id: Profile.find_by_name("ALUNOS").id )
    else
      user = User.new(name: name, email: email, password: 12345678, password_confirmation: 12345678, student_id: id, profile_id: Profile.find_by_name("ALUNOS").id )
      user.save!
    end
  end

end