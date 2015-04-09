
require 'spec_helper'

describe Popularity::RedditComment do
  context "non-reddit url" do
    use_vcr_cassette "reddit-comment"

    subject {
      Popularity::RedditComment.new('http://google.com')
    }

    it "should be invalid" do
      expect(subject.valid?).to eq(false)
    end

    it "should have no resposne" do
      expect(subject.response).to eq(false)
    end
  end

  context "non-comment url" do
    use_vcr_cassette "reddit-comment"

    subject {
      Popularity::RedditComment.new('http://www.reddit.com/r/Fitness/comments/30wleu/me_and_my_wife_joined_the_gym_9_months_ago_we')
    }

    it "should be invalid" do
      expect(subject.valid?).to eq(false)
    end

    it "should have no resposne" do
      expect(subject.response).to eq(false)
    end
  end

  context "reddit url" do
    use_vcr_cassette "reddit-comment"

    subject {
      Popularity::RedditComment.new('http://www.reddit.com/r/Fitness/comments/30wleu/me_and_my_wife_joined_the_gym_9_months_ago_we/cpwrwat')
    }

    it "should be valid" do
      expect(subject.valid?).to eq(true)
    end

    it "should have response" do
      expect(subject.response).to_not eq(false)
    end

    it "should have correct score" do
      expect(500).to eq(subject.score)
    end

    it "should have correct total" do
      expect(subject.total).to eq(subject.score)
    end
  end
end