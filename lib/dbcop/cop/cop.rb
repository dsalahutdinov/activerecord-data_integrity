# frozen_string_literal: true

module Dbcop
  # Checking cop base class
  class Cop
    attr_reader :model

    def initialize(model)
      @model = model
    end
    
    def name
      self.class.name.gsub("Dbcop::", "").gsub("::","/")
    end
  end
end
