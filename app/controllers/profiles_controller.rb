class ProfilesController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  before_action :roles, only: [:new, :edit, :update, :create]

  def show
  end

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def update
    @profile = Profile.find(params[:id])

    @profile.update_attributes(profile_params)

    respond_with @profile, :location => profiles_path
  end

  def create
    @profile = Profile.new(profile_params)

    @profile.save

    respond_with @profile, :location => profiles_path
  end


  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:adm, :name, :role_ids => [])
    end

    def roles
      @roles = Role.all
    end
end