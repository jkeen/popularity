require 'spec_helper'

describe Popularity::RedditShare do
  context "valid url" do
    use_vcr_cassette "reddit"

    subject {
      Popularity::RedditShare.new('http://google.com')
    }

    it "should have multiple results" do
      expect(25).to eq(subject.results.size)
    end

    it "should roll up score counts" do
      totals = subject.results.collect { |r| r.score }
      expect(totals.reduce(:+)).to eq subject.score
    end

    it "should roll up comment counts" do
      totals = subject.results.collect { |r| r.comment_count }
      expect(totals.reduce(:+)).to eq subject.comment_count
    end

    it "should allow access to underlying results" do
      expect(4687).to eq(subject.results.first.score)
    end

    context "json" do
      let(:json) { subject.to_json }

      it "should include post count in json" do 
        expect(25).to eq(json["posts"])
      end

      it "should comments in json" do 
        expect(json["comments"]).to_not be_nil
      end

      it "should score in json" do 
        expect(json["score"]).to_not be_nil
      end
    end
  end
end