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

      it "should not be sql" do
        subject.should_not be_sql
      end
    end

    context "A raw sql metric" do
      context "From a string" do
        subject do
          Class.new(Metric) do
            sql "SELECT name, created_at FROM users"
          end.new
        end

        it "groups by created_at by default" do
          subject.group_by.should == :created_at
        end

        it "gets the scope" do
          subject.sql.should == "SELECT name, created_at FROM users"
        end

        it "raises an exception when adding an option" do
          expect {
            subject.class.option "active" do |scope|
              scope.active
            end
          }.to raise_exception(SqlMetricCannotHaveOption)
        end

        it "should be sql" do
          subject.should be_sql
        end
      end

      context "From a block" do
        subject do
          Class.new(Metric) do
            sql { "SELECT name, created_at FROM users" }
          end.new
        end

        it "groups by created_at by default" do
          subject.group_by.should == :created_at
        end

        it "gets the scope" do
          subject.sql.should == "SELECT name, created_at FROM users"
        end

        it "raises an exception when adding an option" do
          expect {
            subject.class.option "active" do |scope|
              scope.active
            end
          }.to raise_exception(SqlMetricCannotHaveOption)
        end

        it "should be sql" do
          subject.should be_sql
        end
      end
    end
    
    context "a metric missing the scope" do
      subject do
        Class.new(Metric) do 
        end
      end

      it "raises an exception when accessing the scope" do
        expect { subject.scope }.to raise_exception(MissingScope)
      end
    end

    context "a metric missing the sql" do
      subject do
        Class.new(Metric) do
        end
      end

      it "raises an exception when accessing the sql" do
        expect { subject.sql }.to raise_exception(MissingSql)
      end
    end

    context "A simple scope metric with multiple options" do
      subject do
        Class.new(Metric) do 
          scope { User }
          option "active" do |scope|
            scope.active
          end
        end.new
      end

      it "should have multiple options" do
        subject.options.size.should == 2
        subject.options['default'].should be_present
        subject.options['active'].should be_present
      end
    end
  end
end
