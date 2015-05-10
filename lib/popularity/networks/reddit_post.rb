module Popularity
  class RedditPost < Crawler
    stats :score, :comments

    def score
      begin
        response_json[0]["data"]["children"][0]["data"]["score"]
      rescue
        0
      end
    end

    def comments
      begin
        response_json[0]["data"]["children"][0]["data"]["num_comments"]
      rescue
        0
      end
    end

    def valid?
      return false unless host == 'reddit.com'

      path = URI.parse(@url).path
      path.split('/').delete_if { |a| a.empty? }.size < 6
    end

    def name
      "reddit"
    end

    protected

    def request_url
      "#{@url}.json"
    end
  end

  class RedditResult < RedditPost
    # A stubbed out version of a RedditPost so RedditShare can
    # stub in the json response it already has

    stats :score, :comments

    def initialize(url, r)
      super(url)
      @url = url
      @response = r

      self
    end

    def has_response?
      true
    end

    def reddit_url
      @url
    end

    def valid?
      URI.parse(@url).host
    end

    def fetch
      false
    end

    def fetch_async
      false
    end
  end
end
