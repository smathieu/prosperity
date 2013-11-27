require_dependency "prosperity/application_controller"
require 'csv'

module Prosperity
  class MetricsController < ApplicationController
    before_filter :get_metric, only: [:show, :data, :export]

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
                url: data_metric_path(id: @metric.id, extractor: ext.key, option: option, period: period, start_time: params[:start_time], end_time: params[:end_time]),
              }
            end
          }
        end
      end
    end

    def data
      ext = get_extractor(Metric.extractors[params.fetch(:extractor, "group")])

      json = {
        data: ext.to_a,
        key: ext.key
      }
      render json: json
    end

    def export
      file = CSV.generate do |csv|
        csv << ['Date'] + @metric.extractors.map(&:key)

        dates = []
        Prosperity::Periods::ALL.fetch(period).each_period(start_time, end_time) { |date| dates << date }
        extractor_data = @metric.extractors.map { |extractor_klass| get_extractor(extractor_klass).to_a }

        dates.each_with_index do |date, index|
          row = []
          row << date.strftime('%Y-%m-%d')
          extractor_data.each do |extractor_row|
            row << extractor_row[index]
          end

          csv << row
        end  
      end
      render text: file, content_type: 'text/csv'
    end

    private

    def memoize_times
      @end_time ||= params[:end_time].present? ? Time.parse(params[:end_time].to_s) : Time.now
      @start_time ||= params[:start_time].present? ? Time.parse(params[:start_time].to_s) : @end_time - 12.months
    end

    def start_time
      memoize_times
      @start_time
    end

    def end_time
      memoize_times
      @end_time
    end

    def get_extractor(ext_klass)
      p = Prosperity::Periods::ALL.fetch(period)
      ext_klass.new(@metric, option, start_time, end_time, p)
    end

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
