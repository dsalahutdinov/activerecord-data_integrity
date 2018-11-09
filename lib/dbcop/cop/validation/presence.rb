# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module Validation
    # Checks foreign key presence to the parent table of belongs_to association
    class Presence < Cop
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
        column = model
                 .connection
                 .columns(model.table_name)
                 .find { |col| col.name == attribute.to_s }
        return true if column.nil?

        (!column.null).tap do |result|
          progress(result ? '.' : 'D')
          log("has nullable column #{attribute} with presence validation") unless result
        end
      end

      def validators
        model
          .validators
          .select { |v| v.is_a?(ActiveRecord::Validations::PresenceValidator) }
      end
    end
  end
end
