# frozen_string_literal: true

module ActiveRecord
  module DataIntegrity
    # collects result info for rendering
    class Collector
      class << self
        def log(cop, message)
          data.push(cop: cop, message: message)
        end

        def progress(_cop, char)
          print char
        end

        def render
          group_data_by_cop_name.each do |cop_name, items|
            items.each do |item|
              puts "#{Rainbow(cop_name).red}:"\
                     " #{Rainbow(item[:cop].model.name).yellow}"\
                     " #{item[:message]}"
            end
          end
        end

        private

        def data
          @data ||= []
        end

        def group_data_by_cop_name
          data.each_with_object({}) do |item, hash|
            hash[item[:cop].class.cop_name] ||= []
            hash[item[:cop].class.cop_name] << item
          end
        end
      end
    end
  end
end
