class GroupsController < ApplicationController

  before_filter :authorize_controller!

  before_action :set_group, only: [:show, :edit, :update, :destroy, :second_change_exam, :questionnaire, :re_enrollment, :have_book ]
  before_action :set_classroom, only:[:new, :create]

  before_action :set_new_classrooms, only:[:edit, :update]


  def have_book
    if @group.have_book
      @group.update_attribute(:have_book, false)
      flash[:notice] = 'Aluno marcado para comprar livro'
    else
      flash[:info] = 'Aluno já possui comprar livro'
      @group.update_attribute(:have_book, true)
    end
    redirect_to  buy_books_course_path(@group.classroom.course)
  end
  
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

  def re_enrollment
    if @group.re_enrollment
      @group.update_attribute(:re_enrollment, false)
      flash[:alert] = 'Rematricula cancelada'
    else
      flash[:info] = 'Rematricula feita com sucesso'
      @group.update_attribute(:re_enrollment, true)
    end
    
    if params[:list] == 'true' 
      redirect_to re_enrollments_calendars_path(list: true)
    else
      redirect_to  @group.classroom      
    end  
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

    respond_with @group, :location => @group.classroom
  end

  def update
    @group = Group.find(params[:id])

    @group.update_attributes(group_params)
    
    if params[:manager_fault] == 'true'
      respond_with @group, :location => @group.classroom.company      
    else
      respond_with @group, :location => @group.classroom      
    end
  end

  def destroy
    @group = Group.find(params[:id])

    @group.destroy

    respond_with @group, :location => @group.classroom

  end


  private

    def set_new_classrooms
      @classrooms_new = current_calendar.
                        classrooms
    
    end

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
