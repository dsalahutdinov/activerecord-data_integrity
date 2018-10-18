# frozen_string_literal: true

module Dbcop
  class CLI
    def initialize; end

    def run
      # Rails load ugly hack :)
      require File.expand_path('config/environment', Dir.pwd)
      Kernel.const_set(:APP_PATH, File.expand_path('config/application', Dir.pwd))
      Rails.application.eager_load!
      Rails.logger.level = 4

      checks = [Dbcop::Checks::TablePresence, Dbcop::Checks::ForeignKeyPresence]
      results = []

      require 'stringio'
      require 'logger'

      strio = StringIO.new
      logger = Logger.new strio

      checks.each do |check|
        logger.info(check.name)

        ActiveRecord::Base.descendants.each do |model|
          results << check.new(model, logger).call
        end
      end
      puts strio.string
      exit(1) if results.include?(false)
    end
  end
end
