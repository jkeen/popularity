module Popularity
  class Medium < Crawler
    stats :recommends

    def recommends
      response_json["payload"]["value"]["count"]
    end

    def valid?
      host == 'medium.com'
    end

    protected

    def medium_id
      @url.split("/").last.split("-").last
    end

    def request_url
      "https://medium.com/p/#{medium_id}/upvotes"
    end

    def response_json
      JSON.parse(response.sub("])}while(1);</x>", ""))
    end
  end
end
