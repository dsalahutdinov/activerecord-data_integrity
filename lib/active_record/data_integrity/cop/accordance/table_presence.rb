# frozen_string_literal: true

require_relative '../cop'

module ActiveRecord
  module DataIntegrity
    module Accordance
      # Check the presence of the underlying table for the model
      class TablePresence < ActiveRecord::DataIntegrity::Cop
        def call
          connection.table_exists?(model.table_name).tap do |result|
            log("has no underlying table #{model.table_name}") unless result
            progress(result, 'T')
          end
        end
      end
    end
  end
end
