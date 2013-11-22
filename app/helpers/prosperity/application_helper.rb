module Prosperity
  module ApplicationHelper
    def app_name
      "Prosperity" 
    end

    def link_to_metric(metric)
      link_to metric.new.title, metric_path(id: metric.name)
    end
  end
end
