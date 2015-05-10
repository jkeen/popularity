module Popularity
  class RedditShare < Crawler
    include Popularity::ContainerMethods
    stats :comments, :score, :posts

    def initialize(*args)
      super(*args)
      posts_json = response_json["data"]["children"]
      posts_json.each do |child|
        new_json = response_json.clone

        new_json["data"]["children"] = [child]
        url = "http://reddit.com#{child["data"]["permalink"]}"
        post = RedditResult.new(url, JSON.dump([new_json]))

        self.add_result(post)
      end

      self
    end

    def posts
      @results.size rescue 0
    end

    def name
      "reddit"
    end

    def request_url
      "http://www.reddit.com/r/search/search.json?q=url:#{@url}"
    end
  end
end
