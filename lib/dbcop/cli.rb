module Dbcop
  class CLI
    def initialize; end

    def run
      # Rails load ugly hack :)
      Kernel.const_set(:APP_PATH, File.expand_path('config/application', Dir.pwd))
      Rails.application.eager_load!

      checks = [Dbcop::Checks::TablePresence, Dbcop::Checks::ForeignKeyPresence]
      results = []

      require 'stringio'
      require 'logger'

      strio = StringIO.new
      logger = Logger.new strio

      ActiveRecord::Base.descendants.each do |model|
        checks.each do |check|
          results << check.new(model, logger).call
        end
      end
      puts strio.string
      exit(1) if results.include?(false)
    end
  end
end
