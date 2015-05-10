require 'spec_helper'

describe Popularity::Soundcloud do
  context "non-soundcloud url" do
    use_vcr_cassette "soundcloud-invalid"

    subject {
      Popularity::Soundcloud.new('http://google.com')
    }

    it "should be invalid" do
      expect(subject.valid?).to eq(false)
    end

    it "should have no resposne" do
      expect(subject.response).to eq(false)
    end
  end

  context "soundcloud url" do
    use_vcr_cassette "soundcloud-valid"

    subject {
      Popularity::Soundcloud.new('http://soundcloud.com/jeffkeen/i-know-its-you')
    }

    it "should be valid" do
      expect(subject.valid?).to eq(true)
    end

    it "should have response" do
      expect(subject.response).to_not eq(false)
    end

    it "should have correct number of plays" do
      expect(14710).to eq(subject.plays)
    end

    it "should have correct number of likes" do
      expect(12).to eq(subject.likes)
    end

    it "should have correct number of downloads" do
      expect(0).to eq(subject.downloads)
    end

    it "should have correct number of comments" do
      expect(2).to eq(subject.comments)
    end

    it "should have the correct total" do
      expect(subject.comments + subject.downloads + subject.likes + subject.plays).to eq(subject.total)
    end

    context "json" do
      let(:json) { subject.as_json }

      it "should have required attributes in json" do
        [:plays, :likes, :downloads, :comments].each do |att|
          expect(subject.send(att)).to eq(json[att.to_s])
        end
      end
    end

  end
end
