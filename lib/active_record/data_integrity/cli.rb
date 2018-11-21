# frozen_string_literal: true

require 'thor'
require_relative 'config'

module ActiveRecord
  module DataIntegrity
    # CLI application class
    class CLI < Thor
      desc 'check [OPTIONS] [MODEL_NAMES]', 'Runs the data integrity check'
      method_option :only,
                    type: :string,
                    desc: 'List of the rules to check, separated with comma' \
                          ', e.g. --only BelongsTo/ForeignKey,Accordance/PrimaryKey'
      def check(*model_names)
        config = Config.new(options.merge(model_names: model_names))

        require_rails

        results = config.cops.map do |cop_class|
          config.models.each do |model|
            cop_class.new(model).call
          end
        end

        ActiveRecord::DataIntegrity::Collector.render

        exit(1) if results.include?(false)
      end
      default_task :check

      desc 'version', 'Print the current version'
      def version
        puts ActiveRecord::DataIntegrity::VERSION
      end
      map %w[--version -v] => :version

      private

      def require_rails
        # Rails load ugly hack :)
        require File.expand_path('config/environment', Dir.pwd)
        Kernel.const_set(:APP_PATH, File.expand_path('config/application', Dir.pwd))
        Rails.application.eager_load!
        Rails.logger.level = 0
      end
    end
  end
end
