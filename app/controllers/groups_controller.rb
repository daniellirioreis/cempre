class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom, only:[:new, :create]
  def index
    @classrooms = current_company.classrooms.open
  end

  def show
    respond_with(@group)
  end

  def new
    @group = Group.new(classroom_id: @classroom.id, status: StatusGroup::ACTIVE)
    @students = current_company.students.sorted
  end

  def edit
    @group.status = params[:status]
  end

  def create
    @group = Group.new(group_params)

    @group.save

    respond_with @group, :location => new_group_path(:classroom_id => @group.classroom_id)
  end

  def update
    @group = Group.find(params[:id])

    @group.update_attributes(group_params)

    respond_with @group, :location => new_group_path(:classroom_id => @group.classroom_id)
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def set_classroom
      @classroom = Classroom.find(params[:classroom_id])
    end

    def group_params
      params.require(:group).permit(:student_id, :classroom_id, :status, :new_classroom_id, :justification)
    end
end
