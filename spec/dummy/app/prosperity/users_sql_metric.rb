class UsersSqlMetric < Prosperity::Metric
  sql "SELECT * FROM users"
end

