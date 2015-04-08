require 'open-uri'
require 'open_uri_redirections'
require 'json'

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

    def eligible? 
      true # to be overridden in subclasses
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

    def fetch
      begin
        f = Timeout::timeout(10) { open(request_url, :allow_redirections => :safe) }
        response = f.read()
      rescue OpenURI::HTTPError, Timeout::Error, SocketError
        nil
      end
    end
  end
end