module Popularity
	class Facebook < Crawler
    stats :shares, :comments

    def shares
      response_json['shares'].to_f.to_i
    end

    def comments
      response_json['comments'].to_f.to_i
    end

    protected

    def request_url
     "http://graph.facebook.com/?id=#{@url}"
   end
 end
end
