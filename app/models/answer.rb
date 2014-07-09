class Answer < ActiveRecord::Base
  belongs_to :company
  validates  :name, presence: true
  def to_s
    name
  end
end
