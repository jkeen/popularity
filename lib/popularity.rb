
require 'popularity/crawler'
require 'popularity/aggregator'
require 'popularity/facebook'
require 'popularity/twitter'
require 'popularity/pinterest'
require 'popularity/google_plus'
require 'popularity/medium'
require 'popularity/reddit_post'
require 'popularity/reddit_comment'
require 'popularity/reddit_share'
require 'popularity/soundcloud'
require 'popularity/github'

module Popularity
  TYPES = [Facebook, Twitter, Pinterest, GooglePlus, RedditShare, RedditPost, RedditComment, Medium, Soundcloud, Github]

  def self.search(*urls)
  	response = {}

    Search.new(:urls => urls)
  end

  class Search
    attr_accessor :aggregators

    def initialize(options = {})
      self.aggregators = []

      options[:urls].each do |url|
        a = Aggregator.new(url)
        self.aggregators << a
      end
    end 

    def total
      total = 0
      self.aggregators.each do |a|
        total += a.total
      end

      total
    end
  end
end