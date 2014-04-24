class Book < ActiveRecord::Base
  belongs_to :company
  has_many :rents

  validates :company_id, :code, :title, :level, :language, presence: true

  has_enumeration_for :level, :with => LevelBook,  :create_helpers => true, :create_scopes => true
  has_enumeration_for :language, :create_helpers => true, :create_scopes => true

  def returned
    rents.not_returned.empty?
  end

  def to_s
    "#{title}(#{code})"
  end
end
