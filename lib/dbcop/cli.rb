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
          cop = cop_class.new(model)
          collector = Dbcop::Collector.new(cop)
          collectors << collector
          results << cop.call(collector)
        end
      end

      collectors.each do |collector|
        puts "#{Rainbow(collector.cop.name).red}: #{Rainbow(collector.cop.model.name).yellow} #{collector.data.first}" unless collector.data.empty?
      end

      exit(1) if results.include?(false)
    end
  end
end
