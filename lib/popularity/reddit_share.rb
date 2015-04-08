module Popularity
  class RedditShare < Crawler
    def score
      return unless has_response?
      response_json["data"]["children"].collect do |child|
        child["data"]["score"]
      end
    end

    def comment_count
      return unless has_response?

      response_json["data"]["children"].collect do |child|
        child["data"]["num_comments"]
      end
    end

    def info 
      {:score => score, :comments => comment_count}
    end

    def total
      comment_count.reduce(:+).to_i + score.reduce(:+).to_i
    end

    def name
      "reddit"
    end

    protected

    def request_url
      "http://www.reddit.com/r/search/search.json?q=url:#{@url}"
    end
  end
end