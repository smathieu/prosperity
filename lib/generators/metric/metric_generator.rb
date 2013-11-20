class MetricGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_metric
    template "metric.rb.erb", File.join("app", "prosperity", class_path, "#{file_name}_metric.rb")
  end
end
