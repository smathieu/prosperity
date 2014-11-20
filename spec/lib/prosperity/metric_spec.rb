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
        expect(subject.group_by).to eq(:created_at)
      end

      it "gets the scope" do
        expect(subject.scope).to eq(User)
      end

      it "should not be sql" do
        expect(subject).not_to be_sql
      end

      it "should have the default aggregate" do
        expect(subject.aggregate).to be_an(Aggregate::Count)
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
          expect(subject.group_by).to eq(:created_at)
        end

        it "gets the scope" do
          expect(subject.sql).to eq("SELECT name, created_at FROM users")
        end

        it "raises an exception when adding an option" do
          expect {
            subject.class.option "active" do |scope|
              scope.active
            end
          }.to raise_exception(SqlMetricCannotHaveOption)
        end

        it "should be sql" do
          expect(subject).to be_sql
        end
      end

      context "From a block" do
        subject do
          Class.new(Metric) do
            sql { "SELECT name, created_at FROM users" }
          end.new
        end

        it "groups by created_at by default" do
          expect(subject.group_by).to eq(:created_at)
        end

        it "gets the scope" do
          expect(subject.sql).to eq("SELECT name, created_at FROM users")
        end

        it "raises an exception when adding an option" do
          expect {
            subject.class.option "active" do |scope|
              scope.active
            end
          }.to raise_exception(SqlMetricCannotHaveOption)
        end

        it "should be sql" do
          expect(subject).to be_sql
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
        expect(subject.options.size).to eq(2)
        expect(subject.options['default']).to be_present
        expect(subject.options['active']).to be_present
      end
    end

    context "A metric with a custom group by" do
      subject do
        Class.new(Metric) do 
          scope { User }
          group_by "users.created_at"
        end.new
      end

      describe '#group_by' do
        subject { super().group_by }
        it { should == 'users.created_at' }
      end
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
        expect(aggregate).to be_an(Aggregate::Sum)
        expect(aggregate.column).to eq(:some_column)
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
        expect(subject.value_at.call).to eq(:expected)
      end

      describe ".ruby?" do
        it "should be true" do
          expect(subject.class.ruby?).to eq(true)
          expect(subject.ruby?).to eq(true)
        end
      end
    end
  end
end
