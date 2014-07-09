class Rent < ActiveRecord::Base
  belongs_to :book
  belongs_to :student

  delegate :title, :code, :level, :level_humanize, :description , to: :book

  validates :book_id, :student_id, presence: true


  scope :not_returned, -> {where("returned = ?", false)}

  def to_s
    student
  end
end
