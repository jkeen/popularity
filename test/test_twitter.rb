require 'helper'

class FacebookTest < Minitest::Test
  def test_total
    VCR.use_cassette("facebook") do
      @p = Popularity::Facebook.new('http://google.com')

      assert_equal (@p.shares + @p.comments), @p.total
    end
  end

  def test_comments
    VCR.use_cassette("facebook") do
      @p = Popularity::Facebook.new('http://google.com')
      
      assert_equal 10121, @p.comments
    end  
  end

  def test_shares
    VCR.use_cassette("facebook") do
      @p = Popularity::Facebook.new('http://google.com')
      
      assert_equal 12081903, @p.shares
    end
  end
end

