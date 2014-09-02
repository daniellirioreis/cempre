require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => default_message = "Você não tem autorização para acessar, favor entrar em contato com o administrador do sistema."
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :define_layout

  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :define_environment_message
  #

  def authorize_controller!
    authorize! action_name.to_sym, full_controller_name
  end

  def full_controller_name
    self.controller_name
  end

  private

  def current_company
    current_user.current_company
  end

  helper_method :current_company

  def current_calendar
    current_user.current_calendar
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
      if current_user.student?
        'student'
      else
        if params['action'] == 'declaration_of_studying'
          'print'
        else
          if params['action'] == 'daily'
            'print'
          else
            if params['action'] == 'down_average'
              'print'
            else
              if params['action'] ==  'print'
                'print'
              else
                if params['action'] == 'report_calendar'
                  'print'
                else
                  if params['action'] == 'report_re_enrollments'
                    'print'
                  else
                    if params['action'] == 'report_schedules'
                      'print'                    
                    else
                      if params['action'] == 'report'
                        'print_not_head'
                      else
                        if params['action'] == 'report_teacher'
                          'print'                                            
                        else
                          if params['action'] == 'buy_books'
                            'print_not_head'
                          else
                            nil                                                                                            
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        
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
