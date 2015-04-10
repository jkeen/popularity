module Popularity
  class Pinterest < Crawler
    def pins
      JSON.parse(response.gsub('receiveCount(','').gsub(')',''))['count'].to_f.to_i
    end

    def as_json(options = {})      
      {"pins" => pins}
    end

    def total
      pins
    end

    protected

    def request_url
      "http://api.pinterest.com/v1/urls/count.json?url=#{@url}"
    end
  end
end