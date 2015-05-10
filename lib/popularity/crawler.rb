require 'open-uri'
require 'open_uri_redirections'
require 'json'
require 'unirest'
require 'pry'

module Popularity
  class Crawler
    attr_reader :url

    def self.stats(*args)
      @property_names ||= []
      args.each do |name|
        @property_names << name
      end
    end

    def self.property_names
      @property_names
    end

    def total
      self.class.property_names.uniq.collect { |n| self.send(n.to_sym) }.select { |t| t.class == Fixnum }.compact.reduce(:+)
    end

    def initialize(url)
      @url = url
    end

    def request_url
      raise NotImplemented
    end

    def response
      @response ||= fetch
    end

    def has_response?
      response #fetch it

      return false if response.nil?
      return false if response.empty?

      true
    end

    def valid?
      true # to be overridden in subclasses
    end

    def async_done?
      @async_done
    end

    def host
      URI.parse(@url).host.gsub('www.', '')
    end

    def response_json
      @json ||= JSON.parse(response)
    end

    def name
      self.class.to_s.split('::').last.gsub(/(.)([A-Z])/,'\1_\2').downcase
    end

    def as_json(options = {})
      json = {}

      self.class.property_names.each do |name|
        json[name.to_s] = self.send(name.to_sym)
      end

      json["total"] = total
      json
    end

    def fetch_async(&block)
      return false unless valid?

      Unirest.get(request_url) do |response|
        @async_done = true
        @response = response.raw_body
        block.call(response.code, response.raw_body) if block_given?
      end
    end

    def fetch
      return false unless valid?

      begin
        response = Unirest.get(request_url)
        @response = response.raw_body
      rescue OpenURI::HTTPError, Timeout::Error, SocketError
        nil
      end
    end
  end
end
