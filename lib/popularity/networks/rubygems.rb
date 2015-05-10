module Popularity
  class Rubygems < Crawler
    stats :downloads

    def downloads
      response_json["downloads"]
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
