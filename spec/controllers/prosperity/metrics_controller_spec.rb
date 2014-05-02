require 'spec_helper'

module Prosperity
  describe MetricsController do
    routes { Prosperity::Engine.routes }
    let(:json) { JSON.parse(response.body) }
    let(:metric) { UsersMetric.new }
    
    describe "GET index" do
      it "returns successfully" do
        get :index
        response.should be_success
      end
    end

    describe "GET show" do
      it "returns a metric" do
        get :show, id: metric.id
        response.should be_success
        assigns(:metric).should be_a(Metric)
      end

      it "returns the metric as JSON" do
        get :show, id: metric.id, format: 'json'
        response.should be_success
        json['id'].should == metric.id
        json['title'].should == metric.title

        options = json['options']
        options.should be_an(Array)
        options.size.should == metric.options.size
        options.map{|o| o['key'] }.sort.should == metric.options.keys.sort

        extractors = json['extractors']
        extractors.should be_an(Array)
        extractors.size.should == metric.options.size
      end
    end

    describe "GET data" do
      it "returns interval data by default" do
        Extractors::Interval.any_instance.stub(to_a: [1,2,3])

        get :data, id: metric.id, format: 'json'
        response.should be_success
        json['data'].should == [1,2,3]
      end

      it "returns the actual start and end time" do
        Extractors::Interval.any_instance.stub(to_a: [1,2,3])
        get :data, id: metric.id, format: 'json'
        response.should be_success
        json['start_time'].should be_present
        json['end_time'].should be_present
      end

      it "lets you specify any extractor key" do
        Extractors::Total.any_instance.stub(to_a: [1,2,3])

        get :data, id: metric.id, extractor: 'total', format: 'json'
        response.should be_success
        json['data'].should == [1,2,3]
        json['key'].should == 'total'
        (DateTime.parse(json['start_time']).to_i - 3.months.ago.to_i).should be <= 1.hour
        json['period_milliseconds'].should == 1.week.to_i * 1000
      end

      it "lets you specify the option parameter" do
        Extractors::Interval.any_instance.stub(to_a: [1,2,3])
        Extractors::Interval.should_receive(:new).with(anything,
            'with_1',
            anything,
            anything,
            anything).and_call_original

        get :data, id: metric.id, option: 'with_1', format: 'json'
        response.should be_success
        json['data'].should == [1,2,3]
      end

      it "lets you specify the period" do
        get :data, id: metric.id, period: 'week', format: 'json'
        response.should be_success
        json['data'].size.should be >= 12
      end

      it "lets you specify the date range" do
        get :data, id: metric.id, period: 'week', start_time: Time.now.beginning_of_day, end_time: Time.now.end_of_day, format: 'json'
        response.should be_success
        json['data'].size.should be >= 1
      end

      it "return 404 error code if specified metric does not exist" do
        get :data, id: 'blah', format: 'json'
        response.code.to_i.should == 404
        json['error'].should be_present
      end
    end
  end
end
