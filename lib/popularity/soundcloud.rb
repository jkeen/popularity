module Popularity
  class Soundcloud < Crawler
    def plays
      response.scan(/\"playback_count\"\:([0-9]*)/).flatten.first.to_f.to_i
    end

    def likes
      response.scan(/\"favoritings_count\"\:([0-9]*)/).flatten.first.to_f.to_i
    end

    def info
      {:plays => plays,
       :likes => likes}
    end

    def total
      plays + likes
    end

    def eligible?
      host == 'soundcloud.com'
    end

    protected

    def response_json
      #not json!
    end

    def request_url
      @url
    end
  end
end