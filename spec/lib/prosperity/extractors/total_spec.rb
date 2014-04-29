require 'spec_helper'

module Prosperity
  describe Extractors::Total do
    it_behaves_like "an extractor"
    let(:expected_data_size) { 14 }

    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 12.months }
    let(:period) { Periods::MONTH }

    let(:data) { subject.to_a }
    let(:metric) { UsersMetric.new }
    let(:option) { 'default' }

    subject { Extractors::Total.new(metric, option, start_time, end_time, period) }

    before do 
      User.delete_all
      [2.years.ago, 1.month.ago, 1.month.from_now].each do |time|
        User.create created_at: time
      end
    end

    context "simple scope" do
      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "returns the counts at it increases" do
          data[0].should == 1
          data[-1].should == 2
        end
      end
    end

    context "simple sql fragment" do
      let(:metric) { UsersSqlMetric.new }

      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "returns the counts at it increases" do
          data[0].should == 1
          data[-1].should == 2
        end
      end
    end

    context "with an option" do
      let(:option) { "no_results" }

      describe "#to_a" do
        it "only returns the results for that option block" do
          data.all?(&:zero?).should be_true          
        end
      end
    end

    context "ruby block" do
      let(:metric) do
        Class.new(Metric) do
          value_at do |time, period, *|
            10
          end
        end.new
      end

      describe "#to_a" do
        it "delegates to the ruby block" do
          data.should == [10] * expected_data_size
        end
      end
    end
  end
end
