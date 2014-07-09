class Enrollment < Student

  after_save :create_group
  attr_accessor :classroom_id

  private

  def create_group
     group = Group.new(student_id: id, classroom_id: classroom_id, status: 0)
     group.save
  end
end