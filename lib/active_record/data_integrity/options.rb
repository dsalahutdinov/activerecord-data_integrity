# frozen_string_literal: true

require 'optparse'

module ActiveRecord
  module DataIntegrity
    # Options parser
    class Options
      def initialize(args)
        @options = {}

        OptionParser.new do |opts|
          opts.on('-o', '--only [COP1,COP2,...]') do |list|
            @options[:only] = list.to_s.split(',') if list.present?
          end
        end.parse(args)
      end

      def only
        @options[:only] || []
      end
    end
  end
end
