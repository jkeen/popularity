require 'spec_helper'

describe Popularity::Medium do
  context "non-medium url" do
    use_vcr_cassette "medium-invalid"

    subject {
      Popularity::Medium.new('http://google.com')
    }

    it "should be invalid" do
      expect(subject.valid?).to eq(false)
    end

    it "should have no resposne" do
      expect(subject.response).to eq(false)
    end
  end

  context "medium url" do
    use_vcr_cassette "medium-valid"

    subject {
      Popularity::Medium.new('https://medium.com/@jeffkeen/call-me-sometime-64ed463c02f0')
    }

    it "should be valid" do
      expect(subject.valid?).to eq(true)
    end

    it "should have response" do
      expect(subject.response).to_not eq(false)
    end

    it "should have correct number of recommends" do
      expect(13).to eq(subject.recommends)
    end

    context "json" do
      let(:json) { subject.to_json }

      it "should have required attributes in json" do 
        expect(subject.recommends).to eq(json["recommends"])
      end
    end
  end
end