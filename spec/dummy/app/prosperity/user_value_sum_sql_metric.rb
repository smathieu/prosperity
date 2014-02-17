class UserValueSumSqlMetric < Prosperity::Metric
  sql "SELECT * FROM users"
  aggregate { sum(:value) }
end
