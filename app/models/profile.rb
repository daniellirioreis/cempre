class Profile < ActiveRecord::Base
  has_and_belongs_to_many :roles

  validates :name,  presence: true

  def to_s
     name
  end

end
