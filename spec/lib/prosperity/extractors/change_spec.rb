require 'spec_helper'

module Prosperity
  describe Extractors::Change do
    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 1.year }
    let(:period) { Periods::MONTH }

    subject { Extractors::Change.new(metric, 'default', start_time, end_time, period) }

    let(:data) { subject.to_a }
    let(:metric) { UsersMetric.new }

    before do 
      User.delete_all
      [2.years.ago, 2.month.ago, 1.month.ago, 1.month.from_now].each do |time|
        User.create created_at: time
      end
    end

    context "simple scope" do
      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == 12  
        end

        it "the value shows the percentage change since the last period" do
          data[6].should == 0.0
          data[-2].should == 100.0
          data[-1].should == 50.0
        end
      end
    end
  end
end

