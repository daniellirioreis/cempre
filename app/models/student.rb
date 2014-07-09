class Student < ActiveRecord::Base
  belongs_to :company
  has_one :user, :dependent => :destroy
  has_many :groups, :dependent => :restrict_with_error
  has_many :events
  has_many :rents

  validates :company_id, :name, presence: true
  # :street, :neighborhood, :city, :federal_unit, :house_number
  validates :name, :email, uniqueness: true
  validates :email, uniqueness: { scope: :company_id }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  after_save :create_user

  scope :sorted, -> { order(:name) }
  scope :block_schedule_different, -> {where(block_schedule_different: true )}
  


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
    idade_calculada = {:ano => nil, :mes => nil, :dia => nil}
    if birth_date.present?
      nascimento = read_attribute(:birth_date)
      hoje = Date.today
      if nascimento.present?
        idade_calculada[:ano] = hoje.year - nascimento.year
        if (hoje.month < nascimento.month) or (hoje.month == nascimento.month and hoje.day < nascimento.day)
          idade_calculada[:ano] -= 1
        end
        idade_calculada[:mes] = hoje.month - nascimento.month
        if (hoje.month < nascimento.month) or (hoje.month == nascimento.month and hoje.day < nascimento.day)
          idade_calculada[:mes] += 12
        end
        idade_calculada[:dia] = hoje.day - nascimento.day
        if hoje.day < nascimento.day
          idade_calculada[:mes] -= 1
          idade_calculada[:dia] += hoje.last_month.at_end_of_month.day
        end
      end
    end
      # retorna um hash da idade descriminando a quantidade de dias, meses e anos que a pessoa possui
      return idade_calculada
  end

  def default_email
    "#{name.gsub(' ', '').downcase}@cempre.com"
  end

  def faults
    Fault.student_id(id)
  end

  def group_active
    groups.active
  end

  def company_active
     group_active.first.company if group_active.any?
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