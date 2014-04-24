class RentsController < ApplicationController
  before_action :set_rent, only: [:show, :edit, :update, :destroy, :returned]

  def new
    @rent = Rent.new(book_id: params[:book_id], returned: false)
  end

  def index
    @book  = current_company.books.find(params[:book_id])
    @rents = @book.rents
  end

  def returned
    @rent.update_attribute(:returned, true)

    flash[:info] = "Livro devolvido com sucesso"

    redirect_to @rent.student

  end

  def create
    @rent = Rent.new(rent_params)

    @rent.save

    respond_with @rent, :location => books_path

  end

  private
    def set_rent
      @rent = Rent.find(params[:id])
    end

    def rent_params
      params.require(:rent).permit(:book_id, :student_id, :returned)
    end

end