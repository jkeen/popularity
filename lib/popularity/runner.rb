module Popularity
  class Runner
    attr_accessor :info
    attr_accessor :hits

    def initialize(url)
      @url = url
      @info = {}
      total_score = []

      # github.com stats only valid for github urls, etc
      selected_types = Popularity::TYPES.collect { |n|
        network = n.new(@url)
        network if network.eligible?
      }.compact

      selected_types.each do |network|
        network.fetch_async do |code, body|
          if network.has_response?
            add_finding(network.name, network)
            @info[network.name] = network.info
            total_score << network.total
          end
        end
      end

      loop do 
        # we want the requests to be asyncronous, but we don't 
        # want gem users to have to deal with async code
        # 
        break if selected_types.all? { |network| network.async_done? }
      end

      @info[:total_score] = total_score.compact.reduce(:+)
    end

    def total
      @info[:total_score]
    end

    protected

    def add_finding(name, network)
      self.hits ||= []
      self.hits << name.to_sym

      self.instance_variable_set "@#{name}", network
      self.class.class_eval do
        define_method(name) { network }
      end
    end

    def to_s
      self.class.name
    end
  end
end
