require 'spec_helper'

describe Popularity::GooglePlus do
  context "valid url" do
    use_vcr_cassette "google_plus"

    subject {
      Popularity::GooglePlus.new('http://google.com')
    }

    it "should return correct plus-one count" do
      expect(11180649).to eq subject.plus_ones
    end

    it "should calculate the correct total" do
      expect(subject.plus_ones).to equal subject.total
    end

    context "json" do
      let(:json) { subject.as_json }

      it "should have required attributes in json" do
        expect(subject.plus_ones).to eq(json["plus_ones"])
      end
    end
  end
end
