
require_relative 'base'

module Dbcop
  module Checks
    class ForeignKeyPresence < Base
      def call
        query = <<~SQL
      SELECT
      tc.constraint_name,
      tc.constraint_type,
      tc.table_name,
      kcu.column_name,
      tc.is_deferrable,
      tc.initially_deferred,
      rc.match_option AS match_type,

      rc.update_rule AS on_update,
      rc.delete_rule AS on_delete,
      ccu.table_name AS references_table,
      ccu.column_name AS references_field
    FROM information_schema.table_constraints tc
    LEFT JOIN information_schema.key_column_usage kcu
      ON tc.constraint_catalog = kcu.constraint_catalog
      AND tc.constraint_schema = kcu.constraint_schema
      AND tc.constraint_name = kcu.constraint_name
    LEFT JOIN information_schema.referential_constraints rc
      ON tc.constraint_catalog = rc.constraint_catalog
      AND tc.constraint_schema = rc.constraint_schema
      AND tc.constraint_name = rc.constraint_name
    LEFT JOIN information_schema.constraint_column_usage ccu
      ON rc.unique_constraint_catalog = ccu.constraint_catalog
      AND rc.unique_constraint_schema = ccu.constraint_schema
      AND rc.unique_constraint_name = ccu.constraint_name
    --- any conditions for table etc. filtering
    WHERE lower(tc.constraint_type) in ('foreign key') AND tc.table_name = '#{model.table_name}'
  SQL

  constraints = ActiveRecord::Base.connection.execute(query).to_a
#  puts constraints.inspect

#  byebug if model.name == "Project" || model.name == "ProjectUser"
  results = []

  model._reflections.select { |k, v| v.is_a?(ActiveRecord::Reflection::BelongsToReflection) }.each do |name, reflection|
    next if reflection.polymorphic?
    begin

    references_table = reflection.class_name.constantize.table_name

    fk = reflection.foreign_key
    res = constraints.any? do |c|
      c['table_name'] == model.table_name &&
        c['references_table'] == references_table &&
        c['column_name'] == fk && c['references_field'] == 'id'
    end
    logger.warn("#{model.name} belongs_to #{reflection.name} but has no fk") unless res
    
    results << res
    rescue NameError => e
      logger.error("Error processing #{model.name}.#{reflection.name}")
      logger.error(e.to_s)
    end
  end

  results.include?(false) ? false : true
      end
    end
  end
end
