# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Saunaclub
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.default_locale = :ja # 追加した
    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s] #追加した
    config.time_zone = "Tokyo" # 追加で足した。日本時間に変更するために
    config.active_record.default_timezone = :local  # 追加で足した。日本時間に変更するために
  end
end
