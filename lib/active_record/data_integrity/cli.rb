# frozen_string_literal: true

require 'thor'
require_relative 'options'

module ActiveRecord
  module DataIntegrity
    # CLI application class
    class CLI < Thor
      attr_reader :options

      desc 'check [OPTIONS]', 'Runs the data integrity check'
      method_option :only,
                    type: :string,
                    desc: 'List of the rules to check, separated with comma' \
                          ', e.g. --only BelongsTo/ForeignKey,Accordance/PrimaryKey'
      def check(_args = ARGV)
        @options = Options.new(options)
        require_rails

        results = cops.map do |cop_class|
          ActiveRecord::Base.descendants.each do |model|
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

      def cops
        @cops ||= begin
          ActiveRecord::DataIntegrity::Cop.descendants.select do |cop|
            options.only.empty? || cop.cop_name.in?(options.only)
          end
        end
      end

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
