# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module Validation
    # Checks foreign key presence to the parent table of belongs_to association
    class Inclusion < Cop
      def call
        false
      end

      private

      def validators
        model
          .validators
          .select { |v| v.is_a?(ActiveRecord::Validations::InclusionValidator) }
      end
    end
  end
end
