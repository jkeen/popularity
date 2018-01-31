# require 'spec_helper'

describe Popularity::Search do
  context "single url" do
    use_vcr_cassette "search"

    subject {
      Popularity.search('http://google.com')
    }

    it "should return correct total" do
      expect(23410825).to equal subject.total
    end

    context "json" do
      let(:json) { subject.as_json }

      it "should have each url as root json key" do
        subject.sources.each do |source|
          expect(json[source.to_s]).to_not be_nil
        end
      end

      it "should have each network as root json key" do
        subject.searches.each do |search|
          expect(json[search.url.to_s]).to_not be_nil
        end
      end

      it "should have each total as root json key" do
        expect(json["total"]).to_not be_nil
      end
    end
  end

  context "multiple url" do
    use_vcr_cassette "search-multi"

    subject {
      Popularity.search("http://google.com", "http://yahoo.com")
    }

    it "should return correct aggregates" do
      shares = subject.searches.collect do |search|
        search.facebook.shares
      end

      expect(subject.facebook.shares).to eq(shares.reduce(:+))
    end

    it "should combine results" do
      expect(subject.searches.collect(&:results).reduce(:+).size).to eq(subject.results.size)
    end

    it "should allow access to individual results" do
      expect(subject.facebook.results.size).to eq(2)
    end

    context "json" do
      let(:json) { subject.as_json }

      it "should have each url as root json key" do
        subject.sources.each do |source|
          expect(json[source.to_s]).to_not be_nil
        end
      end

      it "should have each network as root json key" do
        subject.searches.each do |search|
          expect(json[search.url.to_s]).to_not be_nil
        end
      end

      it "should have each total as root json key" do
        expect(json["total"]).to_not be_nil
      end
    end
  end
end
