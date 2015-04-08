module Popularity
	class Facebook < Crawler
    def shares
      response_json['shares'].to_f.to_i
    end

    def likes
      response_json['likes'].to_f.to_i
    end

    def info
      { :likes => likes,
        :shares => shares }
    end

    def total
      likes + shares
    end

    protected

		def request_url
			"http://graph.facebook.com/?id=#{@url}"
		end
  end
end
