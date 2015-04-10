module Popularity
  class RedditComment < Crawler
    def score
      response_json[1]["data"]["children"][0]["data"]["score"] 
    end

    def as_json(options = {})
      {"score" => score}
    end

    def total
      score
    end

    def valid?
      return false unless host == 'reddit.com'
      
      path = URI.parse(@url).path
      path.split('/').delete_if { |a| a.empty? }.size == 6
    end

    def name
      "reddit"
    end

    protected

    def request_url
      "#{@url}.json"
    end
  end
end
