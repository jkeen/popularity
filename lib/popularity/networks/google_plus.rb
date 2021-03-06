module Popularity
  class GooglePlus < Crawler
    stats :plus_ones

    def plus_ones
      matches = response.scan(/window.__SSR = {c\: (\d+.\d+E?\d+)/)
      matches.flatten.first.to_f.to_i
    end

    protected

    def request_url
      "https://plusone.google.com/_/+1/fastbutton?url=#{URI::encode(@url)}"
    end
  end
end
