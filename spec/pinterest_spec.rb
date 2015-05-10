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

    context "json" do
      let(:json) { subject.as_json }

      it "should have required attributes in json" do
        expect(subject.pins).to eq(json["pins"])
      end
    end
  end
end
