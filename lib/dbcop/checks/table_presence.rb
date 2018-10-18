# frozen_string_literal: true

require_relative 'base'

module Dbcop
  module Checks
    class TablePresence < Base
      def call
        result = ActiveRecord::Base.connection.table_exists?(model.table_name)
        logger.info("#{model.name} has no underlying table #{model.table_name}") unless result
        result
      end
    end
  end
end
