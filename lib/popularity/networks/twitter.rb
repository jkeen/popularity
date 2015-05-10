module Popularity
  class Twitter < Crawler
    stats :tweets

    def tweets
      response_json['count'].to_i if has_response?
    end

    protected

    def request_url
      "https://cdn.api.twitter.com/1/urls/count.json?url=#{@url}"
    end
  end
end
