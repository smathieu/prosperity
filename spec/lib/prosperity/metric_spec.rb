require 'spec_helper'

module Prosperity
  describe Metric do
    context "A simple scope metric" do
      subject do
        Class.new(Metric) do 
          scope { User }
        end.new
      end

      it "groups by created_at by default" do
        subject.group_by.should == :created_at
      end

      it "gets the scope" do
        subject.scope.should == User
      end
    end
  end
end
