# frozen_string_literal: true

require 'dbcop/version'
require 'rails/all'
require 'dbcop/cli'
require 'rainbow'

require 'dbcop/collector'

require 'dbcop/cop/accordance/table_presence'
require 'dbcop/cop/belongs_to/foreign_key'
require 'dbcop/cop/validation/presence'

# Base module for the gem
module Dbcop
end
