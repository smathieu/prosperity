require 'spec_helper'

module Prosperity
  describe Aggregate::AggregateBuilder do
    describe "#build" do
      context "the count aggregate" do
        subject do 
          described_class.new do
            count
          end.build
        end

        it "returns a Aggregate::Count" do
          subject.should be_an(Aggregate::Count)
        end
      end

      AGGREGATES = {
        :sum => Aggregate::Sum,
        :minimum => Aggregate::Minimum,
        :maximum => Aggregate::Maximum,
        :average => Aggregate::Average,
      }

      AGGREGATES.each do |func, type|
        context "the #{func} aggregate" do
          subject do 
            described_class.new do
              send(func, :some_column)
            end.build
          end

          it "returns a #{type}" do
            subject.should be_an(type)
            subject.column.should == :some_column
          end
        end
      end
    end

    context "a sql aggregate from a block" do
      subject do 
        described_class.new do
          "SUM(value)"
        end.build
      end

      it "returns a SQL type" do
        subject.should be_an(Aggregate::Sql)
        subject.to_sql.should == 'SUM(value)'
      end
    end
    
    context "a sql aggregate from a block" do
      subject do 
        described_class.new("SUM(value)").build
      end

      it "returns a SQL type" do
        subject.should be_an(Aggregate::Sql)
        subject.to_sql.should == 'SUM(value)'
      end
    end
  end
end
