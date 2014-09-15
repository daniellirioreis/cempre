class Warning < ActiveRecord::Base
  belongs_to :student
  belongs_to :calendar_day
  validates :student_id, :calendar_day_id, :description, presence: true
end
