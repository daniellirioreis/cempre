class Lesson < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :calendar_day

  validates_uniqueness_of :calendar_day_id, :scope => :classroom_id

  def to_s
    calendar_day
  end

  scope :classroom_id, lambda { |id| where("classroom_id = ?", id) }

end
