module Popularity
  class Aggregator
    attr_accessor :info
    attr_accessor :hits

    def initialize(url)
      @url = url

      @info = {}
      total_score = []
      Popularity::TYPES.each do |n|
        network = n.new(@url)
        if network.eligible? && network.has_response?
          add_finding(network.name, network)
          @info[network.name] = network.info
          total_score << network.total
        end
      end

      @info[:total_score] = total_score.compact.reduce(:+)
      @info
    end

    def total
      @info ||= breakdown
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
