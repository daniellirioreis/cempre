class Teacher < ActiveRecord::Base

  belongs_to :company
  has_many :classrooms

  scope :sorted, -> { order(:name) }

  def to_s
    name
  end

  def age
    if birth_date.present?
      Date.today.year - birth_date.year
    end
  end

end
