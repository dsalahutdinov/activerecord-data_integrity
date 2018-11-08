# frozen_string_literal: true

module Dbcop
  class CLI
    def initialize; end

    def run
      # Rails load ugly hack :)
      require File.expand_path('config/environment', Dir.pwd)
      Kernel.const_set(:APP_PATH, File.expand_path('config/application', Dir.pwd))
      Rails.application.eager_load!
      Rails.logger.level = 0

      cop_classes = [Dbcop::Accordance::TablePresence, Dbcop::BelongsTo::ForeignKey]
      results = []
      collectors = []

      cop_classes.each do |cop_class|
        ActiveRecord::Base.descendants.each do |model|
          resulsts << cop_class.new(model).call
        end
      end

      Dbcop::Collector.render

      exit(1) if results.include?(false)
    end
  end
end
