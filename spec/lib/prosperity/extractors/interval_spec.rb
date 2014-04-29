require 'spec_helper'

module Prosperity
  describe Extractors::Interval do
    let(:expected_data_size) { 14 }
    it_behaves_like "an extractor"

    let(:start_time) { 1.year.ago }
    let(:end_time) { start_time + 1.year }
    let(:period) { Periods::MONTH }
    let(:data) { subject.to_a }

    subject { Extractors::Interval.new(metric, 'default', start_time, end_time, period) }

    before do
      User.delete_all
      [2.years.ago, 1.month.ago, 1.month.from_now].each do |time|
        User.create created_at: time
      end
      User.create created_at: 1.week.ago
    end

    context "simple scope" do
      let(:metric) { UsersMetric.new }

      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "only returns models from that period" do
          data.sum.should == 2
        end
      end
    end

    context "simple sql fragment" do
      let(:metric) { UsersSqlMetric.new }

      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "only returns models from that period" do
          data.sum.should == 2
        end
      end

      context "with weekly period" do
        let(:period) { Periods::WEEK }

        describe "#to_a" do
          it "returns the one entry per period" do
            [54, 53].should include(data.size)
          end

          it "only returns models from that period" do
            data.sum.should == 2
          end
        end

        context "with alternate start and end times" do
          let(:start_time) { 2.weeks.ago }
          let(:end_time) { start_time + 2.weeks }

          describe "#to_a" do
            it "returns the one entry per period" do
              data.size.should == 4
            end

            it "only returns models from that period" do
              data.sum.should == 1
            end
          end
        end
      end
    end

    context "sql fragment with nested WITH" do
      let(:metric) do
        Class.new(Metric) do
          sql "WITH all_columns AS (SELECT * FROM users) SELECT name, created_at FROM users"
        end.new
      end

      describe "#to_a" do
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end

        it "only returns models from that period" do
          data.sum.should == 2
        end
      end
    end

    context "a metric with a sum aggregate" do
      before do
        User.create! value: 1
        User.create! value: 3
      end

      context "a non sql metric" do
        let(:metric) do
          Class.new(Metric) do
            scope { User }
            aggregate { sum(:value) }
          end.new
        end

        describe "#to_a" do
          it "returns the one entry per period" do
            data.size.should == expected_data_size
            data[-2].should == User.all.sum(:value)
          end
        end
      end

      context "a sql metric" do
        let(:metric) do
          Class.new(Metric) do
            sql "SELECT * FROM users"
            aggregate { sum(:value) }
          end.new
        end

        describe "#to_a" do
          it "returns the one entry per period" do
            data.size.should == expected_data_size
            data[-2].should == User.all.sum(:value)
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
            data.should == [0] * expected_data_size
          end
        end
      end
    end
  end
end
