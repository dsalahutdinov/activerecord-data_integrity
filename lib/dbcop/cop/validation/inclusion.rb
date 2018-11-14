# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module Validation
    # Checks foreign key presence to the parent table of belongs_to association
    class Inclusion < Cop
      def call
        results = validators.map do |validator|
          validator.attributes.map do |attribute|
            valid?(attribute)
          end
        end.flatten

        results.none?(&:!)
      end

      private

      def valid?(attribute)
        column = find_column(attribute)
        return true if column.nil?

        result = (column.type == :enum)
        progress(result, 'D')
        !column && log("has column #{attribute} with inclusion which is not enum") unless result
        result
      end

      def validators
        model
          .validators
          .select { |v| v.is_a?(ActiveModel::Validations::InclusionValidator) }
      end

      def find_column(attribute)
        connection
          .columns(model.table_name)
          .find { |col| col.name == attribute.to_s }
      end
    end
  end
end
