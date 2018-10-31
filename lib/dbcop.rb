# frozen_string_literal: true

require 'dbcop/version'
require 'rails/all'
require 'dbcop/cli'
require 'rainbow'

require 'dbcop/foreign_key'
require 'dbcop/collector'

require 'dbcop/cop/accordance/table_presence'
require 'dbcop/cop/belongs_to/foreign_key'

module Dbcop
end
