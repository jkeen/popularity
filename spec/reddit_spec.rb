require 'spec_helper'

describe Popularity::RedditShare do
  context "valid url" do
    use_vcr_cassette "reddit"

    subject {
      Popularity::RedditShare.new('http://google.com')
    }

    it "should have multiple results" do
      expect(25).to eq(subject.results.size)
    end

    it "should roll up score counts" do
      totals = subject.results.collect { |r| r.score }
      expect(totals.reduce(:+)).to eq subject.score
    end

    it "should roll up comment counts" do
      totals = subject.results.collect { |r| r.comments }
      expect(totals.reduce(:+)).to eq subject.comments
    end

    it "should allow access to underlying results" do
      expect(4687).to eq(subject.results.first.score)
    end

    context "json" do
      let(:json) { subject.as_json }

      it "should include post count in json" do
        expect(json["posts"]).to eq(25)
      end

      it "should have comments in json" do
        expect(json["comments"]).to_not be_nil
      end

      it "should have score in json" do
        expect(json["score"]).to_not be_nil
      end

      it "should have _results in json" do
        expect(json["_results"]).to_not be_nil
      end

      context "results" do
        let(:json_results) { subject.as_json["_results"] }

        it "should equal number of results" do
          expect(subject.results.size).to eq(json_results.size)
        end

        it "should contain the result urls" do
          subject.results.each_with_index do |result, index|
            json_result = json_results[index]

            expect(json_result.keys.first).to eq(result.url)
          end
        end

        it "should contain the correct values" do
          subject.results.each_with_index do |result, index|
            json_result = json_results[index]
            expect(json_result.values.first["score"]).to eq(result.score)
            expect(json_result.values.first["comments"]).to eq(result.comments)
            expect(json_result.values.first["total"]).to eq(result.total)
          end
        end
      end
    end

    context "unknown url" do
      use_vcr_cassette "unknown-reddit-post"
      subject {
        Popularity::RedditShare.new('http://jeffkeen.me/totallyunknown')
      }

      it "should be valid" do
        expect(subject.valid?).to eq(true)
      end

      it "should have response" do
        expect(subject.response).to_not eq(false)
      end

      it "should have correct number of comments" do
        expect(0).to eq(subject.comments)
      end

      it "should have correct score" do
        expect(0).to eq(subject.score)
      end

      it "should have correct total" do
        expect(subject.total).to eq(subject.score + subject.comments + subject.posts)
      end

      context "json" do
        let(:json) { subject.as_json }

        it "should include post count in json" do
          expect(0).to eq(json["posts"])
        end

        it "should comments in json" do
          expect(0).to eq(json["comments"])
        end

        it "should score in json" do
          expect(0).to eq(json["score"])
        end

      end
    end
  end
end
