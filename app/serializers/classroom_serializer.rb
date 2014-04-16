class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :name, :day_week, :time_start, :time_end
  has_one :course
  has_one :company
  has_one :teacher
end
