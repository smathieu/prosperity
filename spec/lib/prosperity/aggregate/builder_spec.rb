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

      context "the sum aggregate" do
        subject do 
          described_class.new do
            sum(:some_column)
          end.build
        end

        it "returns a Aggregate::Count" do
          subject.should be_an(Aggregate::Sum)
          subject.column.should == :some_column
        end
      end
    end
  end
end
