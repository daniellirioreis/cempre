class Answer < ActiveRecord::Base
  belongs_to :company
  validates :type_question, :name, presence: true
  def to_s
    name
  end
end
