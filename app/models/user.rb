class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable, :recoverable, :timeoutable


  belongs_to :student
  belongs_to :profile
  delegate :roles, to: :profile

  validates :email, uniqueness: true

  def to_s
    name
  end

  def student?
    student.present?
  end
end
