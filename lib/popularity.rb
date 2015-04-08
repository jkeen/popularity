
require 'popularity/crawler'
require 'popularity/runner'
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
    attr_accessor :runners

    def initialize(options = {})
      self.runners = []

      options[:urls].each do |url|
        a = Runner.new(url)
        self.runners << a
      end
    end 

    def total
      total = 0
      self.runners.each do |a|
        total += a.total
      end

      total
    end
  end
end