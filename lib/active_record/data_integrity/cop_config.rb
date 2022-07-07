# frozen_string_literal: true

module ActiveRecord
  module DataIntegrity
    # Config  parser
    class CopConfig
      attr_reader :config_hash

      def initialize(config_hash:)
        @config_hash = config_hash
      end

      def enabled?
        config_hash.fetch('Enabled', true) != false
      end

      def exclusions
        config_hash.fetch('Exclude', [])
      end

      def ignored_foreign_keys
        config_hash.fetch('IgnoredForeignKeys', [])
      end
    end
  end
end
