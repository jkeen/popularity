module Popularity
  class Rubygems < Crawler
    def downloads
      response_json["downloads"]
    end

    def as_json(options = {})      
      {"downloads" => downloads}
    end

    def total
      downloads
    end
    
    def valid?
      host == 'rubygems.org' && @url =~ /\/gems\//
    end

    protected

    def gem_name
      @url.split("/").last
    end

    def request_url
      "https://rubygems.org/api/v1/gems/#{gem_name}.json"
    end
  end
end