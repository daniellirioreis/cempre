source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'pg'
gem 'foreigner'
gem 'enumerate_it'
gem "cpf_validator"
gem 'cnpj_validator'
gem 'validates_timeliness'
gem 'i18n_alchemy', :git => 'https://github.com/carlosantoniodasilva/i18n_alchemy.git'
gem 'cocoon'
gem "active_model_serializers"
gem 'postgres-copy'
gem 'pundit'
gem 'jquery-inputmask-rails'

gem 'puma'
gem 'devise'
gem 'responders', :git => 'https://github.com/plataformatec/responders.git'
gem 'has_scope'
gem 'simple_form'
gem 'uglifier', '>= 1.3.0'

gem 'will_paginate', '~> 3.0'

group :doc do
  gem 'sdoc', :require => false
end

gem "enumerate_it"

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-doc'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'factory_girl'
  gem 'poltergeist'
  gem 'turnip'
end

# por causa dos problemas do heroku com assets
# do rails 4 rc1
group :production do
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end
