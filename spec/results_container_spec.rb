require 'spec_helper'

describe Popularity::ResultsContainer do
  context "same results" do
    use_vcr_cassette "result-container-test"

    subject {
      Popularity::ResultsContainer.new
    }

    it "should add first result" do
      subject.add_result Popularity::Facebook.new("http://google.com")
      expect(1).to equal(subject.results.size)

      subject.add_result Popularity::Facebook.new("http://facebook.com")
      expect(2).to equal(subject.results.size)
    end
  end

  context "same results" do
    use_vcr_cassette "result-container-test"

    subject {
      Popularity::ResultsContainer.new
    }

    it "should reject different types" do
      subject.add_result Popularity::Facebook.new("http://google.com")
      expect(1).to equal(subject.results.size)

      expect{
        subject.add_result(Popularity::Pinterest.new("http://google.com"))
      } .to raise_error(TypeError)

    end
  end

  context "adding results" do
    use_vcr_cassette "result-container-test"

    subject {
      Popularity::ResultsContainer.new
    }

    it "should add methods together" do
      subject.add_result Popularity::Facebook.new("http://google.com")
      subject.add_result Popularity::Facebook.new("http://yahoo.com")

      expect(subject.results.collect(&:shares).reduce(:+)).to eq(subject.shares)
    end

    it "should add methods together" do
      subject.add_result Popularity::Facebook.new("http://google.com")
      subject.add_result Popularity::Facebook.new("http://yahoo.com")

      expect(subject.results.collect(&:shares).reduce(:+)).to eq(subject.shares)
    end

  end

end
