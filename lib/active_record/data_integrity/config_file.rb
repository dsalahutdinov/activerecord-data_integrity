# frozen_string_literal: true

module ActiveRecord
  module DataIntegrity
    # Config  parser
    class ConfigFile
      attr_reader :file_path

      def initialize(file_path: './.activerecord_data_integrity.yml')
        @file_path = file_path
      end

      def load
        return {} unless exists?

        YAML.safe_load(
          File.read(file_path),
          permitted_classes: [Regexp, Symbol],
          permitted_symbols: [],
          aliases: true
        )
      end

      def exists?
        File.exists?(file_path)
      end
    end
  end
end
