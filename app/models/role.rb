class Role < ActiveRecord::Base
  has_and_belongs_to_many :profiles

  scope :ordered, order(:controller, :action)

  def to_s
    action
  end
end
