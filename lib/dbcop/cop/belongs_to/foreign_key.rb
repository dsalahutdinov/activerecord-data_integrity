# frozen_string_literal: true

require_relative '../cop'

module Dbcop
  module BelongsTo
    # Checks foreign key presence to the parent table of belongs_to association
    class ForeignKey < Cop
      def call(logger = nil)
        results = []

        model._reflections.select { |_k, v| v.is_a?(ActiveRecord::Reflection::BelongsToReflection) }.each do |_name, reflection|
          next if reflection.polymorphic?

          results << validate(reflection, logger)
        end

        results.include?(false) ? false : true
      end

      private

      def validate(reflection, logger)
        begin
          references_table = reflection.class_name.constantize.table_name

          fk = reflection.foreign_key
          res = foreign_keys.any? do |c|
            c.table_name == model.table_name && c.references_table == references_table &&
              c.column_name == fk && c.references_field == 'id'
          end
          if logger && !res
            logger.info(
              "belongs_to #{reflection.name} but has no foreign key to #{references_table}.id"
            )
          end
        rescue NameError
          logger.info("Error processing #{model.name}.#{reflection.name}")
        end

        res
      end

      def foreign_keys
        @foreign_keys ||= Dbcop::ForeignKey.of_table(model.table_name)
      end
    end
  end
end
