# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'

# APP_PATH = File.expand_path('config/application', Dir.pwd) unless defined? APP_PATH

module Dbcop
  class RakeTask < Rake::TaskLib
    def initialize(name = :dbcop, *args, &task_block)
      desc 'Run DbCop' unless ::Rake.application.last_description

      task(name, *args) do |_, task_args|
        require 'rubocop'
        Dbcop::CLI.new.run
      end
    end
  end
end

