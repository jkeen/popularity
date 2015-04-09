require 'spec_helper'

describe Popularity::Twitter do
	context "valid url" do
		use_vcr_cassette "twitter"

		subject {
			Popularity::Twitter.new('http://google.com')
		}

		it "should return correct tweet" do
			expect(11551).to equal subject.tweets
    end

    it "should calculate the correct total" do
      expect(subject.tweets).to equal subject.total
    end
  end
end