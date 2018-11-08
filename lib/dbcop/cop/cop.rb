# frozen_string_literal: true

module Dbcop
  # Checking cop base class
  class Cop
    attr_reader :model

    def initialize(model)
      @model = model
    end

    def name
      self.class.name.gsub('Dbcop::', '').gsub('::', '/')
    end

    def log(msg)
      Dbcop::Collector.log(self, msg)
    end

    def progress(char)
      Dbcop::Collector.progress(self, char)
    end
  end
end
