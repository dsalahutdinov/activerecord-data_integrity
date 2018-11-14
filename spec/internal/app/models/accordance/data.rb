# frozen_string_literal: true

module Accordance
  class Data < ApplicationRecord
    self.primary_key = 'short_id'
  end
end
