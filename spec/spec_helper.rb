# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'bundler/setup'
require 'dbcop'

require 'dotenv/load'
require 'byebug'

Dir['spec/support/**/*.rb'].each { |f| require(File.expand_path(f)) }
RailsInitializer.run

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
