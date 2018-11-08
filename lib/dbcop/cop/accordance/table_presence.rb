# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module Accordance
    # Check the presence of the underlying table for the model
    class TablePresence < Cop
      def call
        ActiveRecord::Base.connection.table_exists?(model.table_name).tap do |result|
          log("has no underlying table #{model.table_name}") unless result
        end
      end
    end
  end
end
