class NotesController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @note = Note.new(user_id: current_user.id)
  end

  def create
    @note = current_company.notes.new(note_params)

    @note.save

    respond_with @note, :location => root_path
  end

  def edit

  end

  def update
    @note = current_company.notes.find(params[:id])

    @note.update_attributes(note_params)

    redirect_to root_path
  end

  def destroy
    @note = Note.find(params[:id])

    @note.destroy

    redirect_to root_path
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:company_id, :user_id, :for_note, :subject )
    end


end