# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module BelongsTo
    # Checks foreign key presence to the parent table of belongs_to association
    class ForeignKey < Cop
      def call
        results = associations.map do |association|
          valid?(association)
        end

        results.none?(&:!)
      end

      private

      def valid?(association)
        to_table = association.class_name.constantize.table_name

        success = model.connection.foreign_keys(model.table_name).any? do |foreign_key|
          foreign_key.to_table == to_table && foreign_key.options.fetch(:primary_key) == 'id'
        end

        !success && log("belongs_to #{association.name} but has no foreign key to #{to_table}.id")
        progress(success ? '.' : 'F')

        success
      rescue NameError
        log("Error processing #{model.name}.#{association.name}")
      end

      def associations
        model
          ._reflections
          .values
          .select { |association| association.is_a?(ActiveRecord::Reflection::BelongsToReflection) }
          .reject(&:polymorphic?)
      end
    end
  end
end