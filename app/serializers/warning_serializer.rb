class WarningSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :student
end
