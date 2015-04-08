module Popularity
  class Github < Crawler
    def stars
      response_json.size
    end

    def info
      { :stars => stars }
    end

    def total
      response_json.size
    end

    def eligible?
      host == 'github.com'
    end

    protected

    def request_url
      parts = url.split("/").last(2)
      repo = parts.last
      owner = parts.first
      "https://api.github.com/repos/#{owner}/#{repo}/stargazers"
    end
  end
end