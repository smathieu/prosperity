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
                url: data_metric_path(id: @metric.id,
                                      extractor: ext.key,
                                      option: option,
                                      period: period,
                                      start_time: start_time,
                                      end_time: end_time),

              }
            end
          }
        end
      end
    end

    def data
      ext_klass = Metric.extractors[params.fetch(:extractor, "interval")]

      p = Prosperity::Periods::ALL.fetch(period)
      ext = ext_klass.new(@metric, option, start_time, end_time, p)

      json = {
        data: ext.to_a,
        key: ext.key,
        label: ext.label,
        start_time: p.actual_start_time(start_time).iso8601,
        end_time: p.actual_end_time(end_time).iso8601,
        period_milliseconds: p.duration * 1000
      }
      render json: json
    end
    private 

    def get_metric
      @metric = MetricFinder.find_by_name(params.fetch(:id)).new
    rescue NameError
      render_json_error("Could not find metric #{params.fetch(:id)}", 404)
    end

    def option
      params.fetch(:option, 'default')
    end
    helper_method :option
  end
end
