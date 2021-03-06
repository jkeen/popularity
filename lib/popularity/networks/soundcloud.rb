module Popularity
  class Soundcloud < Crawler
    stats :plays, :likes, :comments, :downloads

    def plays
      response.scan(/\"soundcloud:play_count\" content=\"([0-9]*)\"/).flatten.first.to_f.to_i
    end

    def likes
      response.scan(/\"soundcloud:like_count\" content=\"([0-9]*)\"/).flatten.first.to_f.to_i
    end

    def comments
      response.scan(/\"soundcloud:comments_count\" content=\"([0-9]*)\"/).flatten.first.to_f.to_i
    end

    def downloads
      response.scan(/\"soundcloud:download_count\" content=\"([0-9]*)\"/).flatten.first.to_f.to_i
    end

    def valid?
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
