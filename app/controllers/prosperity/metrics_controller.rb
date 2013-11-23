require_dependency "prosperity/application_controller"

module Prosperity
  class MetricsController < ApplicationController
    before_filter :get_metric, only: [:show, :data]

    def index
      @metrics = MetricFinder.all
    end

    def show
      respond_to do |format|
        format.html
        format.json do
          render json: {
            id: @metric.id,
            title: @metric.title,
            options: @metric.options.map do |k, option|
              {key: k}
            end,
            extractors: @metric.extractors.map do |ext|
              {
                key: ext.key,
                url: data_metric_path(id: @metric.id, extractor: ext.key, option: option, period: period),
              }
            end
          }
        end
      end
    end

    def data
      ext_klass = Metric.extractors[params.fetch(:extractor, "group")]
      end_time = Time.now
      start_time = end_time - 12.months
      p = Prosperity::Periods::ALL.fetch(period)
      ext = ext_klass.new(@metric, option, start_time, end_time, p)

      json = {
        data: ext.to_a,
        key: ext.key
      }
      render json: json
    end
    private 

    def get_metric
      @metric = MetricFinder.find_by_name(params.fetch(:id)).new
    end

    def option
      params.fetch(:option, 'default')
    end

    def period
      params.fetch(:period, 'month')
    end

    helper_method :option
  end
end
