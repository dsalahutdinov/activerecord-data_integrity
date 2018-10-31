# frozen_string_literal: true

require_relative 'base'

module Dbcop
  module Checks
    class ForeignKeyPresence < Base
      def call
        results = []

        model._reflections.select { |_k, v| v.is_a?(ActiveRecord::Reflection::BelongsToReflection) }.each do |_name, reflection|
          next if reflection.polymorphic?

          results << validate(reflection)
        end

        results.include?(false) ? false : true
      end

      private

      def validate(reflection)
        begin
          references_table = reflection.class_name.constantize.table_name

          fk = reflection.foreign_key
          res = foreign_keys.any? do |c|
            c.table_name == model.table_name && c.references_table == references_table &&
              c.column_name == fk && c.references_field == 'id'
          end
          logger.warn("#{model.name} belongs_to #{reflection.name} but has no fk") if logger && !res
        rescue NameError => e
          logger.error("Error processing #{model.name}.#{reflection.name}")
          logger.error(e.to_s)
        end

        res
      end

      def foreign_keys
        @foreign_keys ||= Dbcop::ForeignKey.of_table(model.table_name)
      end
    end
  end
end
