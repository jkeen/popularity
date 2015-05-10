
module Popularity
  module ContainerMethods
    def self.included(base)
      base.class_eval do
        def results
          @results
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

        def as_json(options ={})
          individual = {}
          total = {}
          @results.collect do |result|
            json = result.as_json
            individual[result.url] = json

            json.each do |key, value|
              next if key == "total"

              if value.is_a?(Hash)
                # RedditShare breaks out into separate results for each reddit link
                # I'm not a big fan of this hacky stuff here
                value.each do |k,v|
                  total[k] ||= 0
                  total[k] += v
                end
              else
                total[key] ||= 0
                total[key] += value
              end
            end
          end

          individual["total"] = total
          individual
        end

        def method_missing(method_sym, *arguments, &block)
          return 0 unless @results
          collection = @results.collect do |result|
            result.send(method_sym, *arguments)
          end

          if collection.all? { |t| t.is_a?(Fixnum) }
            collection.reduce(:+)
          end
        end
      end
    end
  end

  class ResultsContainer
    include Popularity::ContainerMethods
  end
end
