require 'spec_helper'

module Prosperity
  describe Extractors::Base do
    let(:metric) { UsersMetric.new }
    subject { Extractors::Change.new(metric, 'default', start_time, end_time, period) }
    let(:data) { subject.to_a }

    context "Month period" do
      let(:start_time) { Time.new(1981, 7, 10) }
      let(:end_time) { Time.new(2012, 7, 10) }
      let(:period) { Periods::MONTH }

      it "changes the start time to 1981/07/01" do
        subject.start_time.should == Time.new(1981, 7, 1)
      end

      it "changes the end time to 2012/07/31" do
        subject.start_time.should == Time.new(1981, 7, 1)
      end
    end
  end
end