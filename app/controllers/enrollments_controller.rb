class EnrollmentsController < ApplicationController
  # before_filter :authorize_controller!

  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  before_action :check_capacity, only: [:create]


  def index
    @classrooms = current_calendar.classrooms.open_for_enrollments.open
    @quant_classrooms = @classrooms.open_for_enrollments.count
    @vacancy = current_calendar.vacancy
    @groups_active = current_calendar.groups_active.open_for_enrollments.count
    @remaining_vacancies = current_calendar.remaining_vacancies
  end

  def create_re
    @old_classroom = Classroom.find(params[:old_classroom_id])
    @new_classroom = Classroom.find(params[:new_classroom_id])
    message = []

    if params[:status] == 'aprovado'
      @groups = @old_classroom.groups.sorted.approved.re_enrollment.all(:readonly => false)
      @groups.each do |g|
        new_group = Group.new(classroom_id: params[:new_classroom_id], status: StatusGroup::ACTIVE, student_id: g.student_id, re_enrollment: false)
         if new_group.save


           unless @new_classroom.time_start.try(:strftime, '%H:%M').to_s == @old_classroom.time_start.try(:strftime, '%H:%M').to_s
             g.student.update_attribute(:block_schedule_different, true)             
           end
           
           unless @new_classroom.day_week_humanize.to_s == @old_classroom.day_week_humanize.to_s
             g.student.update_attribute(:block_schedule_different, true)             
           end
           

           g.update_attribute(:re_enrollment, false)
           
           
         else
          message  <<  new_group.errors.full_messages
         end
      end
      if message.empty?
        flash[:notice] = 'Rematriculas realizada com sucesso.'
        redirect_to re_enrollments_calendars_path
      else
        flash[:alert] = message.uniq
        redirect_to list_classrooms_to_re_enrollments_enrollments_path(classroom_id: @old_classroom.id, status: "aprovado" )
      end
    end

    if params[:status] == 'reprovado'
      @groups = @old_classroom.groups.sorted.failed.re_enrollment.all(:readonly => false)
      @groups.each do |g|
        new_group = Group.new(classroom_id: params[:new_classroom_id], status: StatusGroup::ACTIVE, student_id: g.student_id, re_enrollment: false)
         if new_group.save
           
           unless @new_classroom.time_start.try(:strftime, '%H:%M').to_s == @old_classroom.time_start.try(:strftime, '%H:%M').to_s
             g.student.update_attribute(:block_schedule_different, true)             
           end
           
           unless @new_classroom.day_week_humanize.to_s == @old_classroom.day_week_humanize.to_s
             g.student.update_attribute(:block_schedule_different, true)             
           end
           
           
           g.update_attribute(:re_enrollment, false)

         else
          message  <<  new_group.errors.full_messages
         end
      end
      if message.empty?
        flash[:notice] = 'Rematriculas realizada com sucesso.'
        redirect_to re_enrollments_calendars_path
      else
        flash[:alert] = message.uniq
        redirect_to list_classrooms_to_re_enrollments_enrollments_path(classroom_id: @old_classroom.id, status: "reprovado" )
      end

    end

  end

  def list_classrooms_to_re_enrollments
    @classroom_old = Classroom.find(params[:classroom_id])
    if @classroom_old.calendar.next_calendar.present?
      if params[:status] == 'aprovado'
        sequence = @classroom_old.sequence + 1
        @classrooms_new = @classroom_old.calendar.next_calendar.
                                                classrooms.
                                                sequence_and_type_course(sequence, @classroom_old.type_course)

        @groups = @classroom_old.groups.sorted.approved.re_enrollment

        @title = 'Rematricula Aprovados'
      end

      if params[:status] == 'reprovado'
        @title = 'Rematricula Reprovados'
        sequence = @classroom_old.sequence
        @classrooms_new = @classroom_old.calendar.next_calendar.
                                                  classrooms.
                                                  sequence_and_type_course(sequence, @classroom_old.type_course)

        @groups = @classroom_old.groups.sorted.failed.re_enrollment
      end
      @block = false
    else
      @block = true
    end
  end

  def new
    @enrollment = Enrollment.new(classroom_id: params[:classroom_id])
  end

  def create
    @enrollment = current_company.enrollments.new(enrollment_params)

    @enrollment.save

    respond_with @enrollment, :location => enrollments_path
  end

  def update
    @enrollment = current_company.enrollments.find(params[:id])

    @enrollment.update_attributes(enrollmentt_params)

    respond_with @enrollment, :location => enrollments_path

  end


  private
    def check_capacity
        classroom = Classroom.find(params[:classroom_id])
        if classroom.vacancy == 0
          flash[:alert] = "Inscrição não pode ser concluida! Vaga para #{classroom} no horário de
          #{classroom.time_start.try(:strftime, '%H:%M')} às #{classroom.time_end.try(:strftime, '%H:%M')} - #{classroom.day_week_humanize}
          foi esgotada."
          redirect_to enrollments_path
        end
    end

    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:name,:street, :house_number, :complement, :zip_code, :neighborhood,
                                      :district, :city, :federal_unit, :email, :birth_date, :phone, :classroom_id)
    end

end