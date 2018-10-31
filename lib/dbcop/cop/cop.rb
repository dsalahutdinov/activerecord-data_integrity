# frozen_string_literal: true

module Dbcop
  class Cop
    attr_reader :model, :logger

    def initialize(model, logger = nil)
      @model = model
      @logger = logger
    end
  end
end
