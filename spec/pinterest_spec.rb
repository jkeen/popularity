require 'spec_helper'

describe Popularity::Pinterest do
  context "valid url" do
    use_vcr_cassette "pinterest"

    subject {
      Popularity::Pinterest.new('http://google.com')
    }

    it "should return correct pin count" do
      expect(11278).to eq subject.pins
    end

    it "should calculate the correct total" do
      expect(subject.total).to eq subject.pins
    end
  end
end