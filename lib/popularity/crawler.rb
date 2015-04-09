require 'open-uri'
require 'open_uri_redirections'
require 'json'
require 'unirest'

module Popularity
  class Crawler
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

    def to_json
      {@url => as_json}
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