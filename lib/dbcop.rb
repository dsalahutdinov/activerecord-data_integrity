# frozen_string_literal: true

require 'dbcop/version'
require 'active_record'
require 'dbcop/cli'
require 'dbcop/checks/table_presence'
require 'dbcop/checks/foreign_key_presence'

module Dbcop
  # Your code goes here...
  def self.execute
    #    require File.expand_path('config/application.rb')
    #    ActiveRecord::Base.establish_connection(
    #      YAML.load(File.read("./config/database.yml"))['development']
    #    )
    #
  end
end
