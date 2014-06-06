module Prosperity
  module ApplicationHelper
    def app_name
      "Prosperity" 
    end

    def link_to_metric(metric)
      link_to metric.new.title, metric_path(id: metric.name)
    end

    def body_class
      "#{params[:controller]}-#{params[:action]}".gsub(/\//, '-')
    end

    def navbar_item(name, url, *controllers)
      classes = []

      if controllers.any?{ |c| controller.is_a?(c) }
        classes << 'active'
      end

      content_tag(:li, class: classes) do
        link_to name, url
      end
    end
  end
end
