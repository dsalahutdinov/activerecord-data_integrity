# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'

module Dbcop
  # Main checking rake task
  class RakeTask < Rake::TaskLib
    def initialize(name = :dbcop, *args)
      desc 'Run DbCop' unless ::Rake.application.last_description

      task(name, *args) do |_, _task_args|
        require 'rubocop'
        Dbcop::CLI.new.run
      end
    end
  end
end
