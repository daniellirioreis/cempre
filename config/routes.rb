Donald::Application.routes.draw do

  resources :control_points do 
    get :info, on: :collection
  end
  
  resources :managers do
    get :change_companies, on: :member
    get :create_calendar,  on: :member
    get :change_calendars,  on: :member
  end

  resources :enrollments do
    get :list_classrooms_to_re_enrollments, on: :collection
    get :create_re, on: :collection
  end

  resources :schedules

  resources :lessons

  resources :plans do 
    get :report, on: :member
  end

  resources :questionnaire_questions

  resources :questionnaires

  resources :questions

  resources :answers

  resources :rents do
    get :returned, on: :member
  end

  resources :books

  resources :profiles


  resources :events do
    get :finalize, on: :member
  end

  resources :notes

  resources :exams

  resources :faults do
    get :create_with_click, on: :collection
  end

  resources :calendar_days

  resources :calendars do
    get :finalize, on: :member
    get :results, on: :member
    get :classrooms, on: :member
    get :events, on: :collection
    get :re_enrollments, on: :collection
    get :report_re_enrollments, on: :collection
  end

  resources :groups do
      get :second_change_exam, on: :member
      get :questionnaire, on: :member
      get :re_enrollment, on: :member
      get :have_book, on: :member
  end

  resources :classrooms do
    get :daily, on: :member
    get :generate_lessons, on: :member
    get :schedules, on: :collection
    get :for_month_print_daily, on: :member
    get :schedules_for_week_day, on: :collection
    get :throw_faults, on: :member
    get :throw_exams, on: :member    
    get :report_schedules, on: :collection
  end

  resources :teachers do 
    get :report_teacher, on: :member
  end

  resources :courses do 
    get :buy_books, on: :member
  end

  resources :students do
    get :my_data, on: :member
    get :my_exams, on: :member
    get :declaration_of_studying, on: :member
    get :down_average, on: :collection
    get :bulletin, on: :member
    get :frequency, on: :member
  end


  resources :companies

  resources :birthdays_months do
    get :print,  on: :collection
  end


  devise_for :users

  root "dashboard#index"

end
