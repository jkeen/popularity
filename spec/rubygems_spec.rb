require 'spec_helper'

describe Popularity::Rubygems do
  context "non-rubygems url" do
    use_vcr_cassette "rubygems-invalid"

    subject {
      Popularity::Rubygems.new('http://google.com')
    }

    it "should be invalid" do
      expect(subject.valid?).to eq(false)
    end

    it "should have no resposne" do
      expect(subject.response).to eq(false)
    end
  end

  context "rubygems url" do
    use_vcr_cassette "rubygems-valid"

    subject {
      Popularity::Rubygems.new('https://rubygems.org/gems/popularity')
    }

    it "should be valid" do
      expect(subject.valid?).to be_truthy
    end

    it "should have response" do
      expect(subject.response).to_not eq(false)
    end

    it "should have correct number of downloads" do
      expect(85).to eq(subject.downloads)
    end

    context "json" do
      let(:json) { subject.to_json }

      it "should have required attributes in json" do 
        [:downloads].each do |att|
          expect(subject.send(att)).to eq(json[att.to_s])
        end
      end
    end

  end
end