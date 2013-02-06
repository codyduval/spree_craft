source 'http://rubygems.org'

gem 'json'
gem 'sqlite3'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :test do
  gem "rspec-rails", "~> 2.12.2"
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'faker'
  gem 'pry'
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'nokogiri'
  gem 'capybara'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'faker'
  gem 'launchy'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gemspec
