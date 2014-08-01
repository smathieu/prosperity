require 'spec_helper'

module Prosperity
  describe Extractors::Base do
    let(:metric) { UsersMetric.new }
    subject { Extractors::Change.new(metric, 'default', start_time, end_time, period) }
    let(:data) { subject.to_a }

    let(:start_time) { Time.new(1981, 7, 10) }
    let(:end_time) { Time.new(2012, 7, 10) }

    context "Month period" do
      let(:period) { Periods::MONTH }

      it { expect(subject.start_time.to_i).to eq(Time.new(1981, 7, 1).to_i) }
      it { expect(subject.end_time.to_i).to eq(Time.new(2012, 7, 31, 23, 59, 59).to_i) }
    end

    context "Week period" do
      let(:period) { Periods::WEEK }

      it { expect(subject.start_time.to_i).to eq(Time.new(1981, 7, 6).to_i) }
      it { expect(subject.end_time.to_i).to eq(Time.new(2012, 7, 15, 23, 59, 59).to_i) }
    end

    context "Day period" do
      let(:period) { Periods::DAY }

      it { expect(subject.start_time.to_i).to eq(Time.new(1981, 7, 10, 0, 0, 0).to_i) }
      it { expect(subject.end_time.to_i).to eq(Time.new(2012, 7, 10, 23, 59, 59).to_i) }
    end
  end
end