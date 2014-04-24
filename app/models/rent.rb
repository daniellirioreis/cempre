class Rent < ActiveRecord::Base
  belongs_to :book
  belongs_to :student

  delegate :title, :code, :level, :level_humanize, :description , to: :book

  scope :not_returned, -> {where("returned = ?", false)}

  def to_s
    student
  end
end
