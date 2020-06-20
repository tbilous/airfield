Dir[Rails.root.join('spec/macros/**/*.rb')].sort.each { |f| require f }
RSpec.configure do |config|
  # Capybara.page.driver.header('HTTP_ACCEPT_LANGUAGE', 'en')
  # Capybara.ignore_hidden_elements = false
  config.include AbstractController::Translation
  config.include I18nMacros
  # config.raise_on_missing_translations = true
end
