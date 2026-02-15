source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8", ">= 7.0.8.7"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  # Advanced interactive console
  gem "pry-rails"

  # Optional: Adds 'show-source' and better navigation in Pry
  gem "pry-byebug"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

end

gem 'devise'
gem 'devise-api', github: 'nejdetkadir/devise-api', branch: 'main'
gem 'pundit'
gem 'bootstrap', '~> 5.3'
gem 'font-awesome-sass'
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'aws-sdk-s3'
gem 'active_link_to'
gem 'active_storage_validations'
# gem 'mini_magick'
gem "rqrcode_png", "0.1.5"
gem "rqrcode", "0.10.1"
gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary'
gem 'pagy'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq-failures'
# gem 'zebra-zpl'
gem 'jquery-rails'
# gem "chartkick"
gem "paranoia"
gem 'paper_trail'
gem 'prawn'            # For PDF Invoices
gem 'prawn-table'            # For PDF Invoices
gem 'receipts'         # Invoice templates
gem 'fast_excel'       # Bulk Order reports
gem 'image_processing' # For Crop Image variants
# gem 'cssbundling-rails' # Commented out - using sprockets-rails instead