# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module Accordance
    # Checks the primary key integer has 8 bytes length
    class PrimaryKey < Cop
      def call
        log('has short integer primary key') unless valid?
        progress(valid?, 'P')
        valid?
      end

      private

      def valid?
        return true unless connection.table_exists?(model.table_name)

        @valid ||= !connection.primary_keys(model.table_name).map! do |pk|
          column_valid?(pk)
        end.include?(false)
      end

      def column_valid?(name)
        column = connection.columns(model.table_name).find { |c| c.name == name }
        column.type == :integer && column.limit >= 8
      end
    end
  end
end
