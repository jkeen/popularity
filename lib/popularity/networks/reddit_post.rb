module Popularity
  class RedditPost < Crawler
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

    def as_json(options = {})      
      {
        "comments" => comments,
        "score" => score
      }
    end

    def total
      comments + score
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
end
