require_dependency "prosperity/application_controller"

module Prosperity
  class MetricsController < ApplicationController
    def index
      @metrics = MetricFinder.all
    end

    def show
      @metric = MetricFinder.find_by_name(params.fetch(:id)).new
    end
  end
end
