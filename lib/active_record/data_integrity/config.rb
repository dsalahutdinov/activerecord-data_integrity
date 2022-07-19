# frozen_string_literal: true

require 'optparse'

module ActiveRecord
  module DataIntegrity
    # Config  parser
    class Config
      attr_reader :only, :model_names

      def initialize(options)
        @only = options.only? ? options.only.to_s.split(',') : []
        @model_names = options.model_names || []
      end

      def cops
        @cops ||= ActiveRecord::DataIntegrity::Cop.descendants.select do |cop|
          only.empty? || cop.cop_name.in?(only)
        end
      end

      def models
        @models ||= ActiveRecord::Base.descendants.select do |model|
          model_names.empty? || model.name.in?(model_names)
        end
      end
    end
  end
end
