class CalendarSerializer < ActiveModel::Serializer
  attributes :id, :date_start, :date_end, :name
end
