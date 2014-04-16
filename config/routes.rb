Donald::Application.routes.draw do

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

  resources :groups

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
  end


  resources :companies

  devise_for :users
  root "dashboard#index"
end
