# frozen_string_literal: true

module Dbcop
  # Checking cop base class
  class Cop
    attr_reader :model
    delegate :connection, to: :model

    def initialize(model)
      @model = model
    end

    def name
      self.class.name.gsub('Dbcop::', '').gsub('::', '/')
    end

    def log(msg)
      Dbcop::Collector.log(self, msg)
    end

    def progress(subresult, false_char = 'E')
      Dbcop::Collector.progress(self, subresult ? '.' : false_char)
    end
  end
end
