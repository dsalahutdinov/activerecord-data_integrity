# frozen_string_literal: true

require_relative '../cop'

module ActiveRecord
  module DataIntegrity
    module HasMany
      # Checks foreign key presence to the parent table of belongs_to association
      class ForeignKey < ActiveRecord::DataIntegrity::Cop
        def call
          results = associations.map do |association|
            valid?(association)
          end

          results.none?(&:!)
        end

        private

        def valid?(association)
          success = foreign_key?(association)
          unless success
            from_table = association.class_name.constantize.table_name
            log("has_many #{association.name} but has no foreign key from #{from_table}.id")
          end
          progress(success, 'F')

          success
        rescue NameError
          log("Error processing #{model.name}.#{association.name}")
        end

        def associations
          model
            ._reflections
            .values
            .select { |association| association.is_a?(ActiveRecord::Reflection::HasManyReflection) }
            .reject(&:polymorphic?)
            .reject { |assoc| assoc.options[:as].present? }
        end

        def foreign_key?(association)
          to_table = model.table_name
          from_table = association.class_name.constantize.table_name
          connection.foreign_keys(association.class_name.constantize.table_name).any? do |foreign_key|
            foreign_key.to_table == to_table && foreign_key.options.fetch(:primary_key) == 'id'
          end || excluded_key?("#{from_table}.id") || excluded_key?(association.name)
        end

        def excluded_key?(name)
          cop_config.ignored_foreign_keys.any? { |key| name.match?(key) }
        end
      end
    end
  end
end
