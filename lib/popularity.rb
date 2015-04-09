
require 'popularity/crawler'
require 'popularity/search'
require 'popularity/results_container'
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
    MultiSearch.new(:urls => urls)
  end

  def self.select_types(url)
    # github.com stats only valid for github urls, etc
    selected_types = Popularity::TYPES.collect { |n|
      network = n.new(@url)
      network if network.valid?
    }.compact
  end

  class MultiSearch
    attr_accessor :searches
    attr_accessor :sources

    def initialize(options = {})
      @searches = options[:urls].collect { |url| Search.new(url) }

      @searches.each do |search|
        search.results.each do |result|
          add_search_result(result)
        end
      end
    end 

    def to_json(options = {})      
      json = {}
      self.searches.collect do |search|
        json[search.url] = search.to_json
      end

      self.sources.collect do |source|
        json[source.to_s] = self.send(source.to_sym).to_json
      end

      json["total"] = total

      json
    end

    def total
      total = 0
      self.searches.each do |a|
        total += a.total
      end

      total
    end

    protected

    def add_search_result(result)
      container = self.instance_variable_get("@#{result.name}") 

      unless container
        @sources ||= [] 
        @sources << result.name.to_sym 
        container = Popularity::ResultsContainer.new
        self.instance_variable_set "@#{result.name}", container
        self.define_singleton_method(result.name.to_sym) { container }
      end

      container.add_result(result)
    end

  end
end