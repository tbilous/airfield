ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/shared_examples/**/*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec/shared_contexts/**/*.rb')].sort.each { |f| require f }
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_bot_rails'
require 'action_cable/testing/rspec'
require 'sidekiq/testing'
require 'rake'
require 'mongoid-rspec'

FactoryBot.definition_file_paths << File.expand_path('factories', __dir__)
FactoryBot.reload
FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

ActiveRecord::Migration.maintain_test_schema!
Rake::Task.define_task(:environment)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!

  config.use_transactional_fixtures = true

  config.before(:suite) do
    Sidekiq::Testing.fake!
  end

  config.before do
    Timecop.return
    Sidekiq::Worker.clear_all
  end

  config.before(:suite) do
    Sidekiq::Testing.fake!
  end

  config.include FactoryBot::Syntax::Methods

  config.filter_rails_from_backtrace!
  config.example_status_persistence_file_path = 'spec/failures.txt'
  config.include ActiveJob::TestHelper
  config.include Mongoid::Matchers, type: :model

  # Clean/Reset Mongoid DB prior to running each test.
  config.before do
    Mongoid.purge!
  end
end
