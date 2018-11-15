# frozen_string_literal: true

module ActiveRecord
  module DataIntegrity
    # CLI application class
    class CLI
      def initialize; end

      def run
        require_rails

        results = cops.map do |cop_class|
          ActiveRecord::Base.descendants.each do |model|
            cop_class.new(model).call
          end
        end

        Dbcop::Collector.render

        exit(1) if results.include?(false)
      end

      private

      def cops
        @cops ||= Dbcop::Cop.descendants
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
