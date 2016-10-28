source "https://rubygems.org"


gem "rails", "4.2.7.1"
gem "rails-api"
gem "puma"
gem "rubocop"
gem "active_model_serializers"



# To use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"

# To use Jbuilder templates for JSON
# gem "jbuilder"

# Use unicorn as the app server
# gem "unicorn"

# Deploy with Capistrano
# gem "capistrano", :group => :development

# To use debugger
# gem "ruby-debug19", :require => "ruby-debug"

group :production do
  gem "rails_12factor"
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "faker"
  gem "coveralls"
  gem "simplecov"
end

group :development do
  gem "web-console", "~> 2.0"
  gem "spring"
end