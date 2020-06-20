Dir[File.expand_path('support/**/*.rb', __dir__)].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 3
  config.order = :random
  config.color = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.after(:all) do # or :each or :all
    FileUtils.rm_rf("#{Rails.root}/public/test/uploads") # remove whole structure
    FileUtils.rm_rf("#{Rails.root}/public/uploads/tmp") # remove whole structure
  end
end
