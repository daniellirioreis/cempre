class Rent < ActiveRecord::Base
  belongs_to :book
  belongs_to :student

  delegate :title, :code, :level, :level_humanize, :description , to: :book

  validates :book_id, :student_id, presence: true


  scope :not_returned, -> {where("returned = ?", false)}
  
  scope :company_id, lambda { |company_id| where("books.company_id = ? ", company_id).joins(:book) }
  

  def to_s
    student
  end
  
  def days_rent
    date = Date.parse(created_at.to_s.split(" ").first)
    (date..Date.today).count    		
  end
end
