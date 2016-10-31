source "https://rubygems.org"

gem "rails", "4.2.7.1"
gem "rails-api"
gem "puma"
gem "rubocop"
gem "active_model_serializers"
gem "jwt"
gem "bcrypt", "~> 3.1.7"

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
