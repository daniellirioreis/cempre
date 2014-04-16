class Teacher < ActiveRecord::Base
  belongs_to :company
  has_many :classrooms
  def to_s
    name
  end
end
