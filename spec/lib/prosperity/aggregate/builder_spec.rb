require 'spec_helper'

module Prosperity
  describe Aggregate::Builder do
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
  end
end
