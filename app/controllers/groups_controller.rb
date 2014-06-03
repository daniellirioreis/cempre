class GroupsController < ApplicationController

  before_filter :authorize_controller!

  before_action :set_group, only: [:show, :edit, :update, :destroy, :second_change_exam, :questionnaire ]
  before_action :set_classroom, only:[:new, :create]


  def questionnaire
    @questionnaire = @group.questionnaire
  end

  def index
    @classrooms = current_company.classrooms.open
  end

  def second_change_exam
    if @group.second_change_exam
      @group.update_attribute(:second_change_exam, false)
      flash[:notice] = '2ª chamada desmarcada com sucesso'
    else
      flash[:info] = '2ª chamada marcada com sucesso'
      @group.update_attribute(:second_change_exam, true)
    end
    redirect_to  @group.classroom
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

    raise group_params.inspect

    @group.update_attributes(group_params)



    respond_with @group, :location => @group.classroom
  end

  def destroy
    @group = Group.find(params[:id])

    @group.destroy

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
