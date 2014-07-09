class GroupSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :student
  has_one :classroom
end
