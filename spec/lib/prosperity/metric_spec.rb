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

      it "should have the default aggregate" do
        subject.aggregate.should be_an(Aggregate::Count)
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

    context "A metric with a custom group by" do
      subject do
        Class.new(Metric) do 
          scope { User }
          group_by "users.created_at"
        end.new
      end

      its(:group_by) { should == 'users.created_at' }
    end

    context "A metric with a a sum aggregate" do
      subject do
        Class.new(Metric) do 
          scope { User }
          aggregate { sum(:some_column) }
        end.new
      end

      let(:aggregate) { subject.aggregate }

      it "has the correct aggregate info" do
        aggregate.should be_an(Aggregate::Sum)
        aggregate.column.should == :some_column
      end
    end

    context "a ruby code metric" do
      subject do
        Class.new(Metric) do
          value_at do |time, period, option|
            :expected
          end
        end.new
      end

      it "has the correct value_at info" do
        subject.value_at.call.should == :expected
      end

      describe ".ruby?" do
        it "should be true" do
          subject.class.ruby?.should == true
          subject.ruby?.should == true
        end
      end
    end
  end
end
