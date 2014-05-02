require 'spec_helper'

module Prosperity
  describe Periods do
    subject { Periods::DAY }

    describe "#each_period" do
      it "iterates until the end time" do
        times = []
        start_time = DateTime.new(2012, 01, 01)
        end_time = DateTime.new(2012, 01, 05)

        subject.each_period(start_time, end_time) do |start_time|
          times << start_time
        end

        times.should == Array.new(7) { |i| DateTime.new(2012, 01, i + 1) }
      end
    end
  end
end
