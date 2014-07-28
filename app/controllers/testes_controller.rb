class TestesController < ApplicationController
  before_action :set_testis, only: [:show, :edit, :update, :destroy]

  def index
    @testes = Testis.all
    respond_with(@testes)
  end

  def show
    respond_with(@testis)
  end

  def new
    @testis = Testis.new
    respond_with(@testis)
  end

  def edit
  end

  def create
    @testis = Testis.new(testis_params)
    @testis.save
    respond_with(@testis)
  end

  def update
    @testis.update(testis_params)
    respond_with(@testis)
  end

  def destroy
    @testis.destroy
    respond_with(@testis)
  end

  private
    def set_testis
      @testis = Testis.find(params[:id])
    end

    def testis_params
      params[:testis]
    end
end
