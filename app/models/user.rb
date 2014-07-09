class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable, :recoverable, :timeoutable

  belongs_to :student
  belongs_to :profile
  belongs_to :current_company, :class_name => "Company", :foreign_key => "current_company_id"
  belongs_to :current_calendar, :class_name => "Calendar", :foreign_key => "current_calendar_id"
  has_and_belongs_to_many :companies
  delegate :adm, to: :profile

  delegate :roles, to: :profile

  validates :email, uniqueness: true

  def to_s
    name
  end

  def student?
    student.present?
  end
end
