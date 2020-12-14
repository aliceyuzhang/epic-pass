ENV['RAILS_ENV'] ||= 'test'

require 'capybara/rspec'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'

EPIC_HOST = 'https://www.epicpass.com'.freeze

# config for headless chrome driver
Capybara.register_driver :selenium_chrome_headless do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
  )
end

# config for chrome driver
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    args: ['--incognito']
  )
end

Capybara.javascript_driver = :chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5 # seconds
  # config.default_driver = :selenium_chrome_headless
  config.default_driver = :selenium_chrome
end

Capybara.app_host = EPIC_HOST

