# frozen_string_literal: true

require 'active_record/data_integrity/version'

require 'rails/all'
require 'active_record/data_integrity/cli'
require 'rainbow'

require 'active_record/data_integrity/collector'

require 'active_record/data_integrity/cop/accordance/table_presence'
require 'active_record/data_integrity/cop/accordance/primary_key'
require 'active_record/data_integrity/cop/belongs_to/foreign_key'
require 'active_record/data_integrity/cop/validation/presence'
require 'active_record/data_integrity/cop/validation/inclusion'
require 'active_record/data_integrity/cop/has_many/foreign_key'

# Base module for the gem
module ActiveRecord
  module DataIntegrity
  end
end
