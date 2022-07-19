# frozen_string_literal: true

module ActiveRecord
  module DataIntegrity
    # Checking cop base class
    class Cop
      attr_reader :model

      delegate :connection, to: :model

      def initialize(model)
        @model = model
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
    end
  end
end
