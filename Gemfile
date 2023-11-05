source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tailwindcss-rails", "~> 2.0"
gem "rspec-rails"
gem 'simple_form'
gem "devise", "~> 4.9"
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem "web-console"
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end
