module Popularity
  class Twitter < Crawler
    def tweets
      response_json['count'].to_i if has_response?
    end

    def total
      tweets
    end

    def as_json(options = {})
      {"tweets" => tweets}
    end

    protected

    def request_url
      "https://cdn.api.twitter.com/1/urls/count.json?url=#{@url}"
    end
  end
end