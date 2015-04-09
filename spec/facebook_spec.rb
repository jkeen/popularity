require 'spec_helper'

describe Popularity::Facebook do
	context "valid url" do
		use_vcr_cassette "facebook"

		subject {
			Popularity::Facebook.new('http://google.com')
		}

		it "should return correct comment count" do
			expect(10121).to equal subject.comments
		end

    it "should return correct share count" do
      expect(12085903).to equal subject.shares
    end

    it "should calculate the correct total" do
      expect(subject.total).to equal (subject.shares + subject.comments)
    end
	end
end