# frozen_string_literal: true

require 'optparse'

module ActiveRecord
  module DataIntegrity
    # Options parser
    class Options
      def initialize(options)
        @options = {
          only: options.only? ? options[:only].to_s.split(',') : nil
        }
      end

      def only
        @options[:only] || []
      end
    end
  end
end
