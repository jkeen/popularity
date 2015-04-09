# require 'spec_helper'

describe Popularity::Search do
  context "single url" do
    use_vcr_cassette "search"

    subject {
      Popularity.search('http://google.com')
    }

    it "should return correct total" do
      expect(23422351).to equal subject.total
    end
  end


  context "multiple url" do
    use_vcr_cassette "search-multi"

    subject {
      Popularity.search("http://google.com", "http://yahoo.com")
    }

    it "should return correct aggregates" do
      shares = subject.searches.collect do |search|
        search.facebook.shares
      end

      expect(subject.facebook.shares).to eq(shares.reduce(:+))
    end

    it "should allow access to individual results" do
      expect(subject.facebook.results.size).to eq(2)
    end
  end
end
