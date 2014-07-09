class BooksController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.student?
      @books = current_user.student.company_active.books
    else
      @books = current_company.books
    end
  end

  def show

  end

  def edit

  end

  def create
    @book = current_company.books.new(book_params)

    @book.save

    respond_with @book, :location => books_path
  end

  def update
    @book = current_company.books.find(params[:id])

    @book.update_attributes(book_params)

    respond_with @book, :location => books_path
  end


  def new
    @book = Book.new
  end

  def destroy
    @book = current_company.books.find(params[:id])

    @book.destroy

    respond_with @book, :location => books_path

  end

  private
    def set_book
      if current_user.student?
        @book = current_user.student.company_active.books.find(params[:id])
      else
        @book = current_company.books.find(params[:id])
      end
    end

    def book_params
      params.require(:book).permit(:title, :description, :level ,:company_id, :code, :language)
    end

end