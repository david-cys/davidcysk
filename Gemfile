source 'https://rubygems.org'
ruby '2.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'haml', '~> 4.0.5'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'devise', '~> 3.2.2' # user authentication
gem 'paperclip', '~> 4.2' # file uploads
gem 'aws-sdk', '~> 1.5.7' # connect paperclip to s3
gem 'active_model_serializers', '~> 0.8.1' # format json output

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'capybara', '~> 2.4'
  gem 'poltergeist', '~> 1.5.1'
  gem 'database_cleaner'
  gem 'pry-byebug'
  gem 'awesome_print'
  gem 'coolline'
  gem 'coderay'
  gem 'pry', '~> 0.10.1'
end

group :development do
  gem 'quiet_assets' # hide the get requests in the logs
  gem 'better_errors' # turn this off while working on AA
end

group :test do
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end

