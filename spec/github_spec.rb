require 'spec_helper'

describe Popularity::Github do
  context "non-github url" do
    use_vcr_cassette "github-invalid"

    subject {
      Popularity::Github.new('http://google.com')
    }

    it "should be invalid" do
      expect(subject.valid?).to eq(false)
    end

    it "should have no response" do
      expect(subject.response).to eq(false)
    end
  end

  context "github url" do
    use_vcr_cassette "github-valid"

    subject {
      Popularity::Github.new('http://github.com/jkeen/tracking_number')
    }

    it "should be valid" do
      expect(subject.valid?).to eq(true)
    end

    it "should have response" do
      expect(subject.response).to_not eq(false)
    end

    it "should have correct number of stars" do
      expect(18).to eq(subject.stars)
    end
  end
end