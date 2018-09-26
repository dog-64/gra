source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.19.0'

# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '> 2.13'
  gem 'selenium-webdriver'

  gem 'rspec', '~> 3.6.0'
  gem 'rspec-its'
  gem 'rspec-rails', '~> 3.6.0'

  gem 'webmock' # имитация запросов к внешним сервисам

  gem 'guard-livereload', require: false # перегрузка страницы в браузере по изменению view-файлов
  gem 'guard-bundler'
  gem 'guard-rails', '0.7.2', require: false
  gem 'guard-rspec', '4.7.3', require: false

  gem 'action-cable-testing'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails', '~> 4.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'launchy' # показ страницы в rspec по save_and_open_page
  gem 'simplecov', require: false
  gem 'webdrivers'
  gem 'webrat'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'slim-rails'
gem 'whenever', require: false

gem 'rest-client' # http-клиент и парсер json

gem 'foreman' # запуск нескольких процессов приложения
gem 'derailed_benchmarks', group: :development # анализ испольования памяти гемами

gem 'json'
gem 'nokogiri'

gem 'prawn' # генерация pdf
gem 'jquery-rails'
gem 'rubyzip' # создание архивов

ruby '2.4.1'
