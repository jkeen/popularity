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

    # it "should return correct comment count" do
    #   pending
    #   # expect([15551, 1033, 663, 1165, 1656, 925, 625, 7482, 1527, 1112, 735, 4871, 3674, 3328, 356, 365, 2305, 544, 569, 3804, 3715, 1261, 1575, 1392, 368]).to equal subject.comment_count
    # end

    # it "should calculate the correct score" do
    #   pending
    #   # expect([5599, 4687, 2729, 3183, 2821, 3918, 4193, 5198, 2508, 2458, 3327, 3890, 3502, 3762, 3075, 7267, 2620, 2650, 4626, 3554, 3239, 4166, 2371, 3655, 1639]).to equal subject.score
    # end

    # it "should calculate the correct total" do
    #   pending
    #   # expect(subject.total).to equal (subject.score + subject.comment_count)
    # end
  end
end