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
            verify_type = @results.first.class.to_s 
            if verify_type.to_s == result.class.to_s
              @results << result
            else
              raise "ResultTypeError", "types must be the same within a results container"
            end
          else
            @results << result
          end
        end

        def to_json
          new_hash = {}
          collection = @results.collect do |result|
            result.send(method_sym, *arguments)
          end

          collection.each do |item|
            item.each do |key, value|
              new_hash[key] ||= 0
              new_hash[key] += value
            end
          end
          new_hash
        end

        def method_missing(method_sym, *arguments, &block)
          # the first argument is a Symbol, so you need to_s it if you want to pattern match
          collection = @results.collect do |result|
            result.send(method_sym, *arguments)
          end

          collection.reduce(:+)
          

        end
      end
    end
  end

  class ResultsContainer
    include Popularity::ContainerMethods
  end
end
