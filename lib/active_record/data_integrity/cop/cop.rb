# frozen_string_literal: true

module ActiveRecord
  module DataIntegrity
    # Checking cop base class
    class Cop
      attr_reader :model, :cop_config
      delegate :connection, to: :model

      def initialize(model, cop_config: CopConfig.new(config_hash: {}))
        @model = model
        @cop_config = cop_config
      end

      def self.cop_name
        name.gsub('ActiveRecord::DataIntegrity::', '').gsub('::', '/')
      end

      def log(msg)
        ActiveRecord::DataIntegrity::Collector.log(self, msg)
      end

      def progress(subresult, false_char = 'E')
        ActiveRecord::DataIntegrity::Collector.progress(
          self,
          subresult ? Rainbow('.').green : Rainbow(false_char).red
        )
      end

      def config
        @config ||= Config.new({})
      end
    end
  end
end
