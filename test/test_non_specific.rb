require 'helper'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class NonSpecificUrlTest < Minitest::Test
  def setup

  end

  def test_total
    VCR.use_cassette("google") do
      p = Popularity.search('http://google.com')
      assert_match 23405566, p.total
    end
  end

  def test_search_info
    VCR.use_cassette("google") do
      p = Popularity.search('http://google.com')
      assert_match 23405566, p.total
    end
  end
end

