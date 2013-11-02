require 'spec_helper'

module Prosperity
  describe Extractors::Count do
    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 1.year }
    let(:period) { Periods::MONTH }

    subject { Extractors::Count.new(metric, start_time, end_time, period) }

    before do 
      User.delete_all
      [2.years.ago, 1.month.ago, 1.month.from_now].each do |time|
        User.create created_at: time
      end
    end

    context "simple scope" do
      let(:metric) { OpenStruct.new(scope: User, group_by: :created_at) }

      describe "#to_a" do
        let(:data) { subject.to_a }

        it "returns the one entry per period" do
          data.size.should == 12  
        end

        it "returns the counts at it increases" do
          data[0].should == 1
          data[-1].should == 2
        end
      end
    end
  end
end
