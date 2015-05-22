module Popularity
  module ContainerMethods
    def self.included(base)
      base.class_eval do
        def results
          @results || []
        end

        def add_result(result)
          @results ||= []

          if @results.size > 0
            verify_type = @results.first.name
            if verify_type == result.name
              @results << result
            else
              raise "ResultTypeError", "types must be the same within a results container"
            end
          else
            @results << result
          end
        end

        def as_json(options = {})
          result_property_names = []
          results_json = self.results.collect do |r|
            json = {}

            r.class.property_names.each do |name|
              json[name.to_s] = r.send(name.to_sym)
            end

            json["total"] = r.total

            {r.url => json}
          end

          json = aggregate_json
          json["_results"] = results_json

          json
        end

        def aggregate_json
          json = {}

          names = if self.class.respond_to?(:property_names)
            self.class.property_names
          else
            self.results.first.class.property_names
          end

          names.each do |name|
            json[name.to_s] = self.send(name.to_sym)
          end

          json["total"] = self.total

          json
        end

        def method_missing(method_sym, *arguments, &block)
          return 0 unless @results
          collection = @results.collect do |result|
            result.send(method_sym, *arguments)
          end

          if collection.all? { |t| t.is_a?(Fixnum) }
            collection.reduce(:+)
          else
            collection.flatten
          end
        end
      end
    end
  end

  class ResultsContainer
    include Popularity::ContainerMethods
  end
end
