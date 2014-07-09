class Question < ActiveRecord::Base
  belongs_to :company
  validates  :name, :type_question, presence: true

  has_enumeration_for :type_question, :create_helpers => true, :create_scopes => true

  def to_s
    name
  end
end
