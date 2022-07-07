# frozen_string_literal: true

require 'optparse'
require_relative 'config_file'
require_relative 'cop_config'

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
        @cops ||= begin
          ActiveRecord::DataIntegrity::Cop.descendants.select do |cop|
            only.empty? ? config_for(cop).enabled? : cop.cop_name.in?(only)
          end
        end
      end

      def models
        @models ||= begin
          ActiveRecord::Base.descendants.select do |model|
            model_names.empty? || model.name.in?(model_names)
          end
        end
      end

      def models_for(cop_class)
        models.select do |model|
          config_for(cop_class).exclusions.none? { |exclusion| exclusion.match?(model.name) }
        end
      end

      def config_for(cop_class)
        hash = config_hash.fetch('AllCops', {}).deep_merge(config_hash.fetch(cop_class.cop_name, {}))
        CopConfig.new(config_hash: hash)
      end

      private

      def selected_cops
        only.empty?
      end

      def config_file
        @config_file ||= ConfigFile.new
      end

      def config_hash
        @config_hash ||= config_file.load
      end
    end
  end
end
