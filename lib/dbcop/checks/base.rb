# frozen_string_literal: true

module Dbcop
  module Checks
    class Base
      attr_reader :model, :logger

      def initialize(model, logger = nil)
        @model = model
        @logger = logger
      end
    end
  end
end
