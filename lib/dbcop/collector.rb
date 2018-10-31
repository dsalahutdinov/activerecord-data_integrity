# frozen_string_literal: true

module Dbcop
  # collects result info for rendering
  class Collector
    attr_reader :cop, :data

    def initialize(cop)
      @cop = cop
      @data = []
    end

    def info(message)
      data.push message
    end
  end
end
