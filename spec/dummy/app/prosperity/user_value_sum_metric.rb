class UserValueSumMetric < Prosperity::Metric
  scope { User }
  aggregate { sum(:value) }
end
