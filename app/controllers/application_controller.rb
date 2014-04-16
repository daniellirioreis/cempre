require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :define_layout

  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :define_environment_message
  #
  private

  def current_company
    Company.first
  end

  helper_method :current_company

  def current_calendar
    Calendar.open.first
  end

  helper_method :current_calendar

  def message
    @message ||= {}
  end

  helper_method :message

  def breadcrumbs
    @breadcrumbs ||= [].tap do |array|
      array << { :url => root_path, :text => "Dashboard" }
    end
  end

  helper_method :breadcrumbs

  def title(*options)
    scope = "#{controller_path}/#{params[:action]}".i18ncase
    @title ||= I18n.t("title.#{scope}", *options)
  end
  helper_method :title

  # def policy(record)
  #   Pundit::PolicyFinder.new(record).policy!.new(current_user, record)
  # end
  #
  # helper_method :policy

  def define_layout
    if user_signed_in?
      if params['action'] == 'declaration_of_studying'
        'print'
      else
        if params['action'] == 'daily'
          'print'
        else
          nil
        end
      end
    else
      "login"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :profile
  end

  def define_environment_message
    message[:alert] ||= []
  end
end
