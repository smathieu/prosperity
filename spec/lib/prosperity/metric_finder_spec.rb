require 'spec_helper'

module Prosperity
  describe MetricFinder do
    subject { MetricFinder.new File.join(TEST_FILES, "metrics") }

    describe "#metrics" do
      let(:metrics) { subject.metrics }

      it "returns an array" do
        expect(metrics).to be_an(Array)
      end

      it "should contain at least one metric" do
        expect(metrics.size).to be > 0
        expect(metrics.first.superclass).to eq(Metric)
      end
    end

    describe ".find_by_name" do
      it "finds a metric by name" do
        metric = described_class.find_by_name('UsersMetric')
        expect(metric).to be < Metric
      end
    end
  end
end
