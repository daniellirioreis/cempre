class Note < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  has_enumeration_for :for_note, :with => ForMessage, :create_helpers => true, :create_scopes => true

  validates :for_note, :subject, presence: true

  def to_s
    subject
  end
end
