require 'spec_helper'

module Prosperity
  describe DataExtractor do
    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 1.year }
    let(:period) { Periods::MONTH }

    subject { DataExtractor.new(metric, start_time, end_time, period) }

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

        it "only returns models from that period" do
          data.sum.should == 1
        end
      end
    end
  end
end
