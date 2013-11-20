require 'spec_helper'

module Prosperity
  describe Extractors::Count do
    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 1.year }
    let(:period) { Periods::MONTH }

    subject { Extractors::Count.new(metric, 'default', start_time, end_time, period) }

    let(:data) { subject.to_a }
    let(:metric) { UsersMetric.new }

    before do 
      User.delete_all
      [2.years.ago, 1.month.ago, 1.month.from_now].each do |time|
        User.create created_at: time
      end
    end

    context "simple scope" do
      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == 12  
        end

        it "returns the counts at it increases" do
          data[0].should == 1
          data[-1].should == 2
        end
      end
    end

    context "with an option" do
      subject { Extractors::Count.new(metric, 'no_results', start_time, end_time, period) }

      describe "#to_a" do
        it "only returns the results for that option block" do
          data.all?(&:zero?).should be_true          
        end
      end
    end
  end
end
