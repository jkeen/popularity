module Popularity
  class Search
    attr_accessor :info
    attr_accessor :results
    attr_accessor :sources
    attr_reader :url

    def initialize(url)
      @url = url
      @info = {}
      total_score = []

      selected_types.each do |network|
        network.fetch_async do |code, body|
          add_result(network)
          begin

          rescue Exception => e
            puts "#{network.name} had an accident"
            puts e.message
            puts e.backtrace.join("\n")
          end
        end
      end

      loop do
        # we want the requests to be asyncronous, but we don't
        # want gem users to have to deal with async code
        #
        break if selected_types.all? { |network| network.async_done? }
      end
    end

    def as_json(options ={})
      json = {}
      self.results.collect do |result|
        json[result.name.to_s] = result.as_json
      end

      self.sources.collect do |source|
        json[source.to_s] = self.send(source.to_sym).as_json
      end

      json["total"] = total

      json
    end

    def total
      self.results.collect(&:total).compact.reduce(:+)
    end

    protected

    def selected_types
      # github.com stats only valid for github urls, etc
      @types ||= Popularity::TYPES.collect { |n|
        network = n.new(@url)
        network if network.valid?
      }.compact
    end

    def add_result(result)
      self.sources ||= []
      self.results ||= []
      self.results << result
      self.sources << result.name.to_sym

      self.instance_variable_set "@#{result.name}", result

      # if there's a facebook result, this class will
      # have a facebook method returning it
      self.define_singleton_method(result.name.to_sym) { result }
    end

    def to_s
      self.class.name
    end
  end
end
