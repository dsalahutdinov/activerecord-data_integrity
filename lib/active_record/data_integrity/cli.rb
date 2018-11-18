# frozen_string_literal: true

require_relative 'options'

module ActiveRecord
  module DataIntegrity
    # CLI application class
    class CLI
      attr_reader :options

      def initialize; end

      def run(args = ARGV)
        @options = Options.new(args)
        require_rails

        results = cops.map do |cop_class|
          ActiveRecord::Base.descendants.each do |model|
            cop_class.new(model).call
          end
        end

        ActiveRecord::DataIntegrity::Collector.render

        exit(1) if results.include?(false)
      end

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
