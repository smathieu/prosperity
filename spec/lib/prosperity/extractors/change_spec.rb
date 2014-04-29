require 'spec_helper'

module Prosperity
  describe Extractors::Change do
    it_behaves_like "an extractor"

    let(:expected_data_size) { 14 }
    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 12.months }
    let(:period) { Periods::MONTH }

    subject { Extractors::Change.new(metric, 'default', start_time, end_time, period) }

    let(:data) { subject.to_a }

    before do 
      User.delete_all
      [2.years.ago, 2.month.ago, 1.month.ago, 1.month.from_now].each do |time|
        User.create created_at: time
      end
    end

    context "simple scope" do
      let(:metric) { UsersMetric.new }

      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "the value shows the percentage change since the last period" do
          data[6].should == 0.0
          data[-3].should == 100.0
          data[-2].should == 50.0
        end
      end
    end

    context "simple sql fragment" do
      let(:metric) { UsersSqlMetric.new }

      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "the value shows the percentage change since the last period" do
          data[6].should == 0.0
          data[-3].should == 100.0
          data[-2].should == 50.0
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
          data.should == [0.0] * expected_data_size
        end
      end
    end
  end
end

