require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Airfield
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.decorator       false
      g.channel         assets: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.template_engine :slim
    end
    config.time_zone = 'Amsterdam'
    config.load_defaults 6.0
    config.autoloader = :classic
    config.generators.system_tests = nil
  end
end
