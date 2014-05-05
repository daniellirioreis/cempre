Donald::Application.routes.draw do

  resources :questionnaire_questions

  resources :questionnaires do
    get :generate, on: :collection
  end

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

  resources :faults

  resources :calendar_days

  resources :calendars do
    get :finalize, on: :member
    get :results, on: :member
    get :classrooms, on: :member
    get :events, on: :member
  end

  resources :groups do
      get :second_change_exam, on: :member
      get :questionnaire, on: :member
  end

  resources :classrooms do
    get :daily, on: :member
    get :generate_lessons, on: :member
    get :schedules, on: :collection
    get :for_month_print_daily, on: :member

  end

  resources :teachers

  resources :courses

  resources :students do
    get :my_data, on: :member
    get :my_exams, on: :member
    get :declaration_of_studying, on: :member
    get :down_average, on: :collection
    get :bulletin, on: :member
  end


  resources :companies

  resources :birthdays_months do
    get :print,  on: :collection
  end


  devise_for :users

  root "dashboard#index"

end
