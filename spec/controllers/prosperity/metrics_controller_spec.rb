require 'spec_helper'

module Prosperity
  describe MetricsController, type: :controller do
    routes { Prosperity::Engine.routes }
    let(:json) { JSON.parse(response.body) }
    let(:metric) { UsersMetric.new }
    
    describe "GET index" do
      it "returns successfully" do
        get :index
        expect(response).to be_success
      end
    end

    describe "GET show" do
      it "returns a metric" do
        get :show, id: metric.id
        expect(response).to be_success
        expect(assigns(:metric)).to be_a(Metric)
      end

      it "returns the metric as JSON" do
        get :show, id: metric.id, format: 'json'
        expect(response).to be_success
        expect(json['id']).to eq(metric.id)
        expect(json['title']).to eq(metric.title)

        options = json['options']
        expect(options).to be_an(Array)
        expect(options.size).to eq(metric.options.size)
        expect(options.map{|o| o['key'] }.sort).to eq(metric.options.keys.sort)

        extractors = json['extractors']
        expect(extractors).to be_an(Array)
        expect(extractors.size).to eq(metric.options.size)
      end
    end

    describe "GET data" do
      it "returns interval data by default" do
        Extractors::Interval.any_instance.stub(to_a: [1,2,3])

        get :data, id: metric.id, format: 'json'
        expect(response).to be_success
        expect(json['data']).to eq([1,2,3])
      end

      it "returns the actual start and end time" do
        Extractors::Interval.any_instance.stub(to_a: [1,2,3])
        get :data, id: metric.id, format: 'json'
        expect(response).to be_success
        expect(json['start_time']).to be_present
        expect(json['end_time']).to be_present
      end

      it "lets you specify any extractor key" do
        Extractors::Total.any_instance.stub(to_a: [1,2,3])

        get :data, id: metric.id, extractor: 'total', format: 'json'
        expect(response).to be_success
        expect(json['data']).to eq([1,2,3])
        expect(json['key']).to eq('total')
        expect(DateTime.parse(json['start_time']).to_i - 3.months.ago.to_i).to be <= 1.hour
        expect(json['period_milliseconds']).to eq(1.week.to_i * 1000)
      end

      it "lets you specify the option parameter" do
        Extractors::Interval.any_instance.stub(to_a: [1,2,3])
        expect(Extractors::Interval).to receive(:new).with(anything,
            'with_1',
            anything,
            anything,
            anything).and_call_original

        get :data, id: metric.id, option: 'with_1', format: 'json'
        expect(response).to be_success
        expect(json['data']).to eq([1,2,3])
      end

      it "lets you specify the period" do
        get :data, id: metric.id, period: 'week', format: 'json'
        expect(response).to be_success
        expect(json['data'].size).to be >= 12
      end

      it "lets you specify the date range" do
        get :data, id: metric.id, period: 'week', start_time: Time.now.beginning_of_day, end_time: Time.now.end_of_day, format: 'json'
        expect(response).to be_success
        expect(json['data'].size).to be >= 1
      end

      it "return 404 error code if specified metric does not exist" do
        get :data, id: 'blah', format: 'json'
        expect(response.code.to_i).to eq(404)
        expect(json['error']).to be_present
      end

      it "returns 404 for a known metric, but unknowd extractor" do
        get :data, id: metric.id, extractor: 'does-not-exist', format: 'json'
        expect(response.code.to_i).to eq(404)
        expect(json['error']).to be_present
      end

      it "handle errors in the metric gracefuly" do
        allow_any_instance_of(metric.class).to receive(:scope) do
          1 / 0
        end
        get :data, id: metric.id, format: 'json'
        expect(response.code.to_i).to eq(400)
        expect(json['error']).to be_present
      end
    end
  end
end
