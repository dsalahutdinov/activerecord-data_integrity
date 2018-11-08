# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module Validation
    # Checks foreign key presence to the parent table of belongs_to association
    class Inclusion < Cop
      def call
        false
      end
    end
  end
end
