module Popularity
	class Facebook < Crawler
    def shares
      response_json['shares'].to_f.to_i
    end

    def comments
      response_json['comments'].to_f.to_i
    end

    def as_json
      { :shares => shares,
        :comments => comments }
    end

    def total
       shares + comments
    end

    protected

		def request_url
			"http://graph.facebook.com/?id=#{@url}"
		end
  end
end
