require_dependency "prosperity/application_controller"

module Prosperity
  class MetricsController < ApplicationController
    def index
      @metrics = MetricFinder.all
    end
  end
end
